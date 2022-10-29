import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2 import Geometry

from backend import db


class SanitaryProtectionZone(db.Model):
    __tablename__ = "SZZ" # СЗЗ (Санитарно-защитная зона)

    id = Column(Integer, primary_key=True, autoincrement=True)
    oid = Column(Integer, nullable=True)
    shapetype = Column(Integer, Enum(shapefile.SHAPETYPE_LOOKUP))
    parts = Column(ARRAY(Integer))
    points = Column(Geometry('POLYGON'))

    bbox = Column(ARRAY(DECIMAL()))

    vid_zouit = Column(String())
