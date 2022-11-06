from operator import or_

import geoalchemy2
from geoalchemy2 import functions
from shapely import wkt
from sqlalchemy import and_

from backend import db
from backend.data.models import Land, StartGround
from backend.data.models.extended.extended_land import ExtendedLand
from backend.tools.bbox import Bbox


def select_all_in_bbox(bbox: Bbox):
    # query = db.session.execute(f"select * from lands where st_intersects(points, st_makevalid('{wkt.dumps(bbox.polygon)}'))").all()
    query = db.session.query(Land).filter(geoalchemy2.functions.ST_Intersects(Land.points,
                                                                              wkt.dumps(bbox.polygon))).all()
    return query


def select_all_extended_in_bbox(bbox: Bbox):
    query = db.session.query(ExtendedLand)\
        .join(Land, ExtendedLand.land_oid == Land.oid)\
        .filter(and_(ExtendedLand.land_oid.isnot(None),
                     geoalchemy2.functions.ST_Intersects(Land.points,
                                                         wkt.dumps(bbox.polygon)))).all()
    print(len(query))
    return query
