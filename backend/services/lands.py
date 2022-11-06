import geoalchemy2
from geoalchemy2 import functions
from shapely import wkt
from backend import db
from backend.data.models import Land
from backend.tools.bbox import Bbox


def select_all_in_bbox(bbox: Bbox):
    # query = db.session.execute(f"select * from lands where st_intersects(points, st_makevalid('{wkt.dumps(bbox.polygon)}'))").all()
    query = db.session.query(Land).filter(geoalchemy2.functions.ST_Intersects(Land.points,
                                                                              wkt.dumps(bbox.polygon))).all()
    return query
