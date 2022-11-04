import geoalchemy2
from flask import jsonify

from backend import app, db
from backend.data.models import Land
from backend.tools import coord_convert


@app.route("/api/<string:entity>/get_polygons", methods=["POST", "GET"])  # type: ignore
def get_polygons_controller(entity: str):
    """
    :param entity:
    :return:
    """
    if entity == "lands":
        return jsonify({
            "lands": [
                {
                    "oid": obj.oid,
                    "polygons": [list(map(lambda p: (p.x, p.y), geoalchemy2.shape.to_shape(obj.points).geoms))]
                } for obj in db.session.query(Land).filter(Land.parts == [0]).limit(1000)
            ]
        })
