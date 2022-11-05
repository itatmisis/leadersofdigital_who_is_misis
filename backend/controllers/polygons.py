import flask
import shapely.geometry

from backend import app
from backend import services
from backend.services import polygons, lands


@app.route("/api/<string:entity>/polygons")
def get_polygons_controller(entity):
    try:
        data_json = services.polygons.get_all_polygons_json(entity)
    except ValueError:
        return flask.abort(404)

    response = flask.make_response(data_json, 200)
    response.headers["Content-Type"] = "application/json"
    response.cache_control.max_age = app.config["CACHE_MAX_AGE"]
    return response


@app.route("/api/lands/get_polygons", methods=["POST"])  # type: ignore
def get_polygons_by_bbox_controller():
    json = flask.request.json
    bbox = json["bbox"]
    try:
        x1, y1 = bbox["bottom_left"]["lat"], bbox["bottom_left"]["lon"]
        x2, y2 = bbox["top_right"]["lat"], bbox["top_right"]["lon"]
        if x1 > x2 or y1 > y2:
            raise ValueError
    except (KeyError, ValueError):
        flask.abort(400, "Invalid bbox")

    selected_lands = services.lands.select_all_in_bbox(shapely.geometry.box(x1, y1, x2, y2))

    response = {
        "lands": services.polygons.serialize_polygons(selected_lands)
    }
    return flask.jsonify(response)
