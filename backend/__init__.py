import os

from dotenv import load_dotenv
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import backend.config

dotenv_path = os.path.join(os.path.dirname(__file__), "..", ".env")
if os.path.exists(dotenv_path):
    load_dotenv(dotenv_path)
else:
    raise FileNotFoundError(".env file not found")

app = Flask(__name__)

if os.environ.get("DEBUG") == "true":
    import flask_cors
    cors = flask_cors.CORS(app, resources={r"/*": {"origins": "*"}})

app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get("DB_URL")
app.config.update(config.CONFIG)
if not os.path.exists(app.config["PREPROCESSED_DATA_PATH"]):
    os.mkdir(app.config["PREPROCESSED_DATA_PATH"])

db = SQLAlchemy(app)

from backend.data import models

with app.app_context():
    db.create_all()

from backend import cli_manager

from backend.controllers import *
