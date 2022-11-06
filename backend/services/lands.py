from shapely import wkt
from backend import db
from backend.tools.bbox import Bbox


def select_all_in_bbox(bbox: Bbox):
    query = db.session.execute(f"select * from lands where st_intersects(points, st_makevalid('{wkt.dumps(bbox.polygon)})'))").all()

    return query
