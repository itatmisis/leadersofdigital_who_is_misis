from sqlalchemy import Column, String

from backend import db
from backend.data.models.base_polygonal_model import BasePolygonalModel


class CulturalHeritage(db.Model, BasePolygonalModel):
    __tablename__ = "cultural_heritage"

    name = Column(String(127))
    number = Column(String(80))  # all entries from dataset were 'None'
    object_id = Column(String(80))
