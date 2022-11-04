from sqlalchemy import Column, String

from backend import db
from backend.data.models.base_polygonal_model import BasePolygonalModel


class SanitaryProtectedZone(db.Model, BasePolygonalModel):
    __tablename__ = "sanitary_protected_zones"

    zone_type = Column(String(255))
