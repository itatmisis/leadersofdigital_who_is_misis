import click
from flask import cli
from backend import app
from backend.tools import dataset_to_db_convert

db_cli = cli.AppGroup("db")


@db_cli.command("load-dataset")
@click.option("--dataset_path", type=click.Path(exists=True), default="Датасет")
def load_dataset(dataset_path):
    dataset_to_db_convert.main(dataset_path)

    print("Dataset loaded successfully")


app.cli.add_command(db_cli)
