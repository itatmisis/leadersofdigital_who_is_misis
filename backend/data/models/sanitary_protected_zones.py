import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2 import Geometry

from backend import db


class SanitaryProtectedZone(db.Model):
    __tablename__ = "sanitary_protected_zones"  # СЗЗ (Санитарно-защитная зона)

    oid = Column(Integer, primary_key=True)
    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"), index=True)
    bbox = Column(Geometry(geometry_type="POLYGON"), index=True)

    zone_type = Column(String(255))
