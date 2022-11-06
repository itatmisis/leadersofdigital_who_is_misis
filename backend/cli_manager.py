import sys
import traceback

import click
from flask import cli
from backend import app
from backend.tools import dataset_to_db_convert, compare_excel

db_cli = cli.AppGroup("db")


@db_cli.command("load-dataset")
@click.option("--dataset_path", type=click.Path(exists=True), default="Датасет")
def load_dataset(dataset_path):
    try:
        dataset_to_db_convert.main(dataset_path, progress_output_stream=sys.stdout)
        print("Dataset loaded successfully")
    except Exception as e:
        print(e)


@db_cli.command("compare")
@click.option("--table1", type=click.STRING)
@click.option("--table2", type=click.STRING)
@click.option("--column", type=click.STRING, multiple=True)
def compare(table1, table2, column):
    res = compare_excel.compare_tables(table1, table2, *column)
    print('MATCHES: {}'.format(len(res.mappings().all())))
    # print(res)


@db_cli.command("load-extended")
def load_extended():
    dataset_to_db_convert.load_extended_lands()


app.cli.add_command(db_cli)
