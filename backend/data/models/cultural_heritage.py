import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2 import Geometry


from backend import db


class CulturalHeritage(db.Model):
    __tablename__ = "cultural_heritage"  # СЗЗ (Санитарно-защитная зона)

    oid = Column(Integer, primary_key=True)
    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"), index=True)
    bbox = Column(Geometry(geometry_type="POLYGON"), index=True)

    name = Column(String(127))
    number = Column(String(80))  # all entries from dataset were 'None'
    object_id = Column(String(80))
