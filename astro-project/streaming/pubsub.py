from google.cloud import pubsub_v1
import json
import random
from datetime import datetime, timezone
from generate_order import GenerateOrder

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(
    'capstone-project-451604',
    'olist_orders_topic')

timestamp = datetime.now(timezone.utc).isoformat(timespec='milliseconds').replace("+00:00", "Z")

for i in range(random.randint(1, 5)):
    """Generate random orders between 1 to 5."""
    # Publish the message
    message_json = json.dumps(GenerateOrder.generate_order())
    future = publisher.publish(
        topic_path,
        message_json.encode('utf-8')
    )
    print(f"Published message ID: {future.result()} with event_timestamp: {timestamp}")
