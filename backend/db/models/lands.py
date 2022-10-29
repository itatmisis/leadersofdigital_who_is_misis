import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY

from backend import db


class Land(db.Model):
    __tablename__ = "lands"

    id = Column(Integer, primary_key=True, autoincrement=True)

    oid = Column(Integer)
    shapetype = Column(Integer, Enum(shapefile.SHAPETYPE_LOOKUP))
    parts = Column(ARRAY(Integer))
    points = Column(ARRAY(DECIMAL(19)))
    bbox = Column(ARRAY(DECIMAL(19)))

    cadnum = Column(String(80))
    address = Column(String(255))
    has_effect = Column(Integer)
    property_t = Column(Integer)
    shape_area = Column(DECIMAL(19))
