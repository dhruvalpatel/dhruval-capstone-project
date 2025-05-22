import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.gcp.pubsub import ReadFromPubSub
from apache_beam.io.gcp.bigquery import WriteToBigQuery
import json
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class OlistOptions(PipelineOptions):
    @classmethod
    def _add_argparse_args(cls, parser):
        parser.add_argument('--input_subscription',
                            default='projects/capstone-project-451604/subscriptions/olist_orders_subscription')

class ParseAndSplitJson(beam.DoFn):
    def process(self, element):
        try:
            logger.info(f"Received raw message: {element.data}")
            data = json.loads(element.data.decode('utf-8'))
            logger.info(f"Parsed message: {data}")

            # Orders table data
            order_data = {
                'order_id': data['data']['orders']['order_id'],
                'customer_id': data['data']['orders']['customer_id'],
                'order_status': data['data']['orders']['order_status'],
                'order_purchase_timestamp': data['data']['orders']['order_purchase_timestamp']
            }
            yield beam.TaggedOutput('orders', order_data)

            # Order_items table data - yield each item individually
            for item in data['data']['order_items']:
                order_item_data = {
                    'order_id': item['order_id'],
                    'order_item_id': item['order_item_id'],
                    'product_id': item['product_id'],
                    'seller_id': item['seller_id'],
                    'price': item['price'],
                    'freight_value': item['freight_value'],
                }
                yield beam.TaggedOutput('order_items', order_item_data)

            # Order_payments table data
            payment_data = {
                'order_id': data['data']['order_payments']['order_id'],
                'payment_sequential': int(data['data']['order_payments']['payment_sequential']),
                'payment_type': data['data']['order_payments']['payment_type'],
                'payment_installments': int(data['data']['order_payments']['payment_installments']),
                'payment_value': data['data']['order_payments']['payment_value']
            }
            yield beam.TaggedOutput('order_payments', payment_data)

            logger.info(f"Transformed orders: {order_data}")
            logger.info(f"Transformed order_items: yielded individually")
            logger.info(f"Transformed payments: {payment_data}")

        except Exception as e:
            logger.error(f"Failed to parse message: {element.data}, Error: {e}")
            return None

def log_write(element):
    logger.info(f"Writing to BigQuery: {element}")
    return element

options = OlistOptions()
with beam.Pipeline(options=options) as pipeline:
    data = (pipeline
            | 'Read from Pub/Sub' >> ReadFromPubSub(
                subscription=options.input_subscription,
                with_attributes=True,
                timestamp_attribute=None)
            | 'Parse and Split JSON' >> beam.ParDo(ParseAndSplitJson()).with_outputs(
                'orders', 'order_items', 'order_payments')
            )

    # Write to orders table
    (data.orders
     | 'Log Orders' >> beam.Map(log_write)
     | 'Write Orders' >> WriteToBigQuery(
                'capstone-project-451604.capstone_dataset.orders',
                schema='order_id:STRING,customer_id:STRING,order_status:STRING,order_purchase_timestamp:TIMESTAMP,'
                       'order_approved_at:TIMESTAMP,order_delivered_carrier_date:TIMESTAMP,'
                       'order_delivered_customer_date:TIMESTAMP,order_estimated_delivery_date:TIMESTAMP',
                write_disposition='WRITE_APPEND',
                # create_disposition='CREATE_IF_NEEDED',
                method='STREAMING_INSERTS'
            ))

    # Write to order_items table
    (data.order_items
     | 'Log Order Items' >> beam.Map(log_write)
     | 'Write Order Items' >> WriteToBigQuery(
                'capstone-project-451604.capstone_dataset.order_items',
                schema='order_id:STRING,order_item_id:STRING,product_id:STRING,seller_id:STRING,'
                       'price:FLOAT,freight_value:FLOAT',
                write_disposition='WRITE_APPEND',
                method='STREAMING_INSERTS'
            ))

    # Write to order_payments table
    (data.order_payments
     | 'Log Payments' >> beam.Map(log_write)
     | 'Write Payments' >> WriteToBigQuery(
                'capstone-project-451604.capstone_dataset.order_payments',
                schema='order_id:STRING,payment_sequential:INTEGER,payment_type:STRING,'
                       'payment_installments:INTEGER,payment_value:FLOAT',
                write_disposition='WRITE_APPEND',
                # create_disposition='CREATE_IF_NEEDED',
                method='STREAMING_INSERTS'
            ))