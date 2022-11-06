from geoalchemy2.types import Geometry
from sqlalchemy import Column, Integer, String

from backend import db
from backend.data.models.base_shp_model import BaseSHPModel


class Organization(db.Model, BaseSHPModel):
    __tablename__ = "organizations"

    point = Column(Geometry(geometry_type="POINT"))

    name = Column(String(255), index=True)
    kol_mest = Column(Integer)
