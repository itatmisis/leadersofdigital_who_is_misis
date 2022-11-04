from backend.data.models import Land
import shapely.geometry
import geoalchemy2.functions
from shapely import wkt
from backend import db


def select_all_in_bbox(bbox: shapely.geometry.box):
    query = db.session\
        .query(Land)\
        .filter(geoalchemy2.functions.ST_Intersects(Land.points, wkt.dumps(bbox)))\
        .all()

    return query


