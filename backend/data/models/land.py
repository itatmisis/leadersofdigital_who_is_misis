from sqlalchemy import Column, Integer, String, DECIMAL

from backend import db
from backend.data.models.base_polygonal_model import BasePolygonalModel


class Land(db.Model, BasePolygonalModel):
    __tablename__ = "lands"

    cadnum = Column(String(80), index=True)
    address = Column(String(255), index=True)
    has_effect = Column(Integer)
    property_t = Column(Integer)
    shape_area = Column(DECIMAL(19))
