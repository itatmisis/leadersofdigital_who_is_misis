from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY
from geoalchemy2.types import Geometry

from backend import db


class Organization(db.Model):
    __tablename__ = "organizations"

    oid = Column(Integer, primary_key=True)

    point = Column(Geometry(geometry_type="POINT"))

    name = Column(String(255), index=True)
    kol_mest = Column(Integer)
