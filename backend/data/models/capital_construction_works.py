import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2 import Geometry

from backend import db


class CapitalConstructionWorks(db.Model):
    __tablename__ = "capital_construction_works"  # ОКС (объект капитального строительства)

    oid = Column(Integer, primary_key=True)
    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"), index=True)
    bbox = Column(Geometry(geometry_type="POLYGON"), index=True)

    cadnum = Column(String(80), index=True)
    address = Column(String(255), index=True)
    area = Column(DECIMAL(19))
