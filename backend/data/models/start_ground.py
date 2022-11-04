from sqlalchemy import Column, String

from backend import db
from backend.data.models.base_polygonal_model import BasePolygonalModel


class StartGround(db.Model, BasePolygonalModel):
    __tablename__ = "start_grounds"

    district = Column(String(20))
    address = Column(String(255), index=True)
