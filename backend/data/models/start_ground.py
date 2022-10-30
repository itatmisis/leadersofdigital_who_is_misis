from sqlalchemy import Column, Integer, String
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2.types import Geometry

from backend import db


class StartGround(db.Model):
    __tablename__ = "start_grounds"

    oid = Column(Integer, primary_key=True)

    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"))
    bbox = Column(Geometry(geometry_type="POLYGON"))

    district = Column(String(20))
    address = Column(String(255))
