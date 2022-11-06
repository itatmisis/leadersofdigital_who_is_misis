from backend.data.models import Land, ExtendedLand
import shapely.geometry
import geoalchemy2.functions
from shapely import wkt
from backend import db
from backend.tools.bbox import Bbox


def select_all_in_bbox(bbox: Bbox):
    query = db.session\
        .query(ExtendedLand)\
        .filter(geoalchemy2.functions.ST_Intersects(ExtendedLand.land.points, wkt.dumps(bbox.polygon)))\
        .all()

    return query


