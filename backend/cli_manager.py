import sys

import click
from flask import cli
from backend import app
from backend.tools import dataset_to_db_convert

db_cli = cli.AppGroup("db")


@db_cli.command("load-dataset")
@click.option("--dataset_path", type=click.Path(exists=True), default="Датасет")
def load_dataset(dataset_path):
    try:
        dataset_to_db_convert.main(dataset_path, progress_output_stream=sys.stdout)
        print("Dataset loaded successfully")
    except Exception as e:
        print(e)

app.cli.add_command(db_cli)
