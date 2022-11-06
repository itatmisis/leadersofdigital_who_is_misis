import flask
import shapely.geometry
from flask import request
from flask_cors import cross_origin

from backend import app
from backend import services
from backend.services import polygons, lands
from backend.tools.bbox import Bbox


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


@app.route("/api/lands/get_polygons")  # type: ignore
@cross_origin()
def get_polygons_by_bbox_controller():
    try:
        x1, y1 = request.args.get("lat1"), request.args.get("lon1")
        x2, y2 = request.args.get("lat2"), request.args.get("lon2")
        if x1 > x2 or y1 > y2:
            raise ValueError
    except (KeyError, ValueError):
        flask.abort(400, "Invalid bbox")

    selected_lands = services.lands.select_all_in_bbox(Bbox(x1, y1, x2, y2))

    response = {
        "lands": services.polygons.serialize_polygons(selected_lands)
    }
    return flask.jsonify(response)


@app.route("/api/organizations/points")
def get_organization_points():
    data_json = services.polygons.get_organizations_json()
    response = flask.make_response(data_json, 200)
    response.headers["Content-Type"] = "application/json"
    response.cache_control.max_age = app.config["CACHE_MAX_AGE"]
    return response