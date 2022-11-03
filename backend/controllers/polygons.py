import geoalchemy2
from flask import jsonify

from backend import app, db
from backend.data.models import Land
from backend.tools import coord_convert


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
        converter = coord_convert.CoordConverter()
        return jsonify({
            "lands": [
                {
                    "oid": obj.oid,
                    "polygons": [
                        list(map(lambda p: converter._from_msk_to_wgs84(p.x, p.y)[::-1],
                                 geoalchemy2.shape.to_shape(obj.points)))
                    ]
                } for obj in db.session.query(Land).filter(Land.parts == [0]).limit(10)
            ]
        })
