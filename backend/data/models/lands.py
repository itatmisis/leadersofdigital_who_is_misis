import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2.types import Geometry

from backend import db


class Land(db.Model):
    __tablename__ = "lands"

    oid = Column(Integer, primary_key=True)

    shapetype = Column(Integer)  # shapefile.SHAPETYPE_LOOKUP
    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"))
    bbox = Column(Geometry(geometry_type="POLYGON"))

    cadnum = Column(String(80), index=True)
    address = Column(String(255))
    has_effect = Column(Integer)
    property_t = Column(Integer)
    shape_area = Column(DECIMAL(19))
