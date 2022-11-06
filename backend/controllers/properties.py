from flask import request, jsonify

from backend import app


@app.route("/api/get_property")
def get_property_controller():
    """
    request json: {
        "entity": "<entity_name>",
        "property": "<property_name>"
    }
    :return:
    """
    # TODO: заглушка
    return jsonify({"status": "ok"})
