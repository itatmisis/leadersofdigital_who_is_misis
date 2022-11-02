from shapely import geometry, wkt

from flask import jsonify

from backend import app, db
from backend.data.models import Land
import geoalchemy2


@app.route("/api/<string:entity>/get_polygons")
def get_polygons_controller(entity: str):  # TODO: Заглушка
    """
    request json: {
        "bbox": [[x1, y1], [x2, y2]]
    }
    :param entity:
    :return:
    """
    if entity == "lands":
        return jsonify({
            "lands": [
                {
                    "oid": obj.oid,
                    "polygons": [
                        list(map(lambda p: (p.x, p.y),  # TODO: перевод в нормальную СК
                                 geoalchemy2.shape.to_shape(obj.points)))
                    ]
                } for obj in db.session.query(Land).filter(Land.parts == [0]).limit(10)
            ]
        })
