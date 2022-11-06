import flask
from backend import app

@app.route('/api/extended_lands/')
def get_extended_lands():

    data_json = {}
    response = flask.make_response(data_json, 200)
    response.headers["Content-Type"] = "application/json"
    return response