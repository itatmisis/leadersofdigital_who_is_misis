from geoalchemy2 import Geometry
from sqlalchemy import Column, Integer
from sqlalchemy.dialects.postgresql import ARRAY

from backend.data.models.base_shp_model import BaseSHPModel


class BasePolygonalModel(BaseSHPModel):
    parts = Column(ARRAY(Integer))
    points = Column(Geometry(geometry_type="MULTIPOINT"))
    bbox = Column(Geometry(geometry_type="POLYGON"))
