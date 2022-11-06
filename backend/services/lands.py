
import geoalchemy2
from shapely import wkt
from sqlalchemy import and_

from backend import db
from backend.data.models import Land
from backend.data.models.extended.extended_land import ExtendedLand
from backend.services import entities
from backend.tools.bbox import Bbox


def select_all_in_bbox(bbox: Bbox, entity: str):
    if not entities.PolygonalEntityManager.is_valid(entity):
        raise ValueError(f"Entity {entity} doesn't exist")
    model = entities.PolygonalEntityManager.get_model(entity)
    query = db.session.query(model).filter(geoalchemy2.functions.ST_Intersects(model.points,
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
