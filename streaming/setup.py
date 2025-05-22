from setuptools import setup, find_packages

setup(
    name='olist_realtime_pipeline',
    version='0.1.0',
    description='Dataflow pipeline for processing real-time Olist order data',
    author='Your Name',
    packages=find_packages(),  # Automatically finds packages like 'tasks'
    install_requires=[
        'apache-beam[gcp]==2.51.0',  # Beam with GCP support
        'google-cloud-pubsub==2.21.1',  # Pub/Sub client
        'google-cloud-bigquery==3.11.4'  # BigQuery client
    ],
    # Include additional files if needed (e.g., configs, data files)
    package_data={
        '': ['*.txt', '*.json'],
    },
)