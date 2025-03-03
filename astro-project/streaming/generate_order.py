"""This module generates order."""
from datetime import datetime, timezone
import uuid
import pandas as pd
import random

timestamp = datetime.now(timezone.utc).isoformat(timespec='milliseconds').replace("+00:00", "Z")
base_dir = '/Users/dpatel/Downloads/Zach/2025_Bootcamp/capstone_project/archive (1)'


class GenerateOrder:

    @staticmethod
    def get_customer_id() -> str:
        """Return random customer id."""
        df = pd.read_csv(f"{base_dir}/olist_customers_dataset.csv")
        values = df['customer_id'].dropna().tolist()
        random_customer = random.choice(values)
        return random_customer

    @staticmethod
    def get_product_id() -> str:
        """Return random product id."""
        df = pd.read_csv(f"{base_dir}/olist_products_dataset.csv")
        values = df['product_id'].dropna().tolist()
        random_customer = random.choice(values)
        return random_customer

    @staticmethod
    def get_seller_id() -> str:
        """Return random seller id."""
        df = pd.read_csv(f"{base_dir}/olist_sellers_dataset.csv")
        values = df['seller_id'].dropna().tolist()
        random_customer = random.choice(values)
        return random_customer

    @staticmethod
    def generate_order() -> dict[str, str]:
        """Generate order."""
        order_id = str(uuid.uuid4())
        price = round(random.randint(10, 300) + random.uniform(0, 1), 2)
        freight_value = round(random.randint(10, 30) + random.uniform(0, 1), 2)
        data = {
            "event_type": "order_initiated",
            "timestamp": timestamp,
            "data": {
                "orders": {
                    "order_id": order_id,
                    "customer_id": GenerateOrder.get_customer_id(),
                    "order_status": "created",
                    "order_purchase_timestamp": timestamp
                },
                "order_items": [
                    {
                        "order_id": order_id,
                        "order_item_id": 1,
                        "product_id": GenerateOrder.get_product_id(),
                        "seller_id": GenerateOrder.get_seller_id(),
                        "price": random.randint(10, 300) + random.randint(0, 1),
                        "freight_value": random.randint(1, 20) + random.randint(0, 1)
                    }
                ],
                "order_payments": {
                    "order_id": order_id,
                    "payment_sequential": 1,
                    "payment_type": "credit_card",
                    "payment_installments": 3,
                    "payment_value": price + freight_value
                }
            }
        }
        return data

    @staticmethod
    def update_order() -> dict:
        """Update order."""
        data = {
            "event_type": "order_status_update",
            "timestamp": "2025-03-05T14:30:00-03:00",
            "data": {
                "orders": {
                    "order_id": "e481f51cbdc54678b7cc49136f2d6af7",
                    "customer_id": "9ef432eb6251297304e76186b10a928d",
                    "order_status": "delivered",
                    "order_purchase_timestamp": "2025-03-02T09:07:00-03:00",
                    "order_delivered_timestamp": "2025-03-05T14:30:00-03:00",
                    "days_to_deliver": 3
                },
                "order_items": [
                    {
                        "order_id": "e481f51cbdc54678b7cc49136f2d6af7",
                        "order_item_id": 1,
                        "product_id": "87283e576d5d95a5b7a8e7f5c73d60b2",
                        "seller_id": "48436dade18ac8b2bce089ec2a041202",
                        "price": 129.90,
                        "freight_value": 15.30
                    }
                ],
                "order_payments": {
                    "order_id": "e481f51cbdc54678b7cc49136f2d6af7",
                    "payment_sequential": 1,
                    "payment_type": "credit_card",
                    "payment_installments": 3,
                    "payment_value": 145.20
                }
            }
        }
        return data


print(GenerateOrder.generate_order())
