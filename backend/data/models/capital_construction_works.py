from sqlalchemy import Column, String, DECIMAL

from backend import db
from backend.data.models.base_polygonal_model import BasePolygonalModel


class CapitalConstructionWorks(db.Model, BasePolygonalModel):
    __tablename__ = "capital_construction_works"  # ОКС (объект капитального строительства)

    cadnum = Column(String(80), index=True)
    address = Column(String(255), index=True)
    area = Column(DECIMAL(19))
