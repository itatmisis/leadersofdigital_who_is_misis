from sqlalchemy import Column, Integer, String, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2.types import Geometry

from backend import db


class Land(db.Model):
    __tablename__ = "lands"

    oid = Column(Integer, primary_key=True)

    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"), index=True)
    bbox = Column(Geometry(geometry_type="POLYGON"), index=True)

    cadnum = Column(String(80), index=True)
    address = Column(String(255), index=True)
    has_effect = Column(Integer)
    property_t = Column(Integer)
    shape_area = Column(DECIMAL(19))
