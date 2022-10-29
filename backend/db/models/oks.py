import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY

from backend import db


class ConstructionWorks(db.Model):
    __tablename__ = "OKS" # ОКС (объект капитального строительства)

    id = Column(Integer, primary_key=True, autoincrement=True)
    oid = Column(Integer, nullable=True)
    shapetype = Column(Integer, Enum(shapefile.SHAPETYPE_LOOKUP))
    parts = Column(ARRAY(Integer))
    points = Column(ARRAY(DECIMAL()))
    bbox = Column(ARRAY(DECIMAL()))

    cadnum = Column(String())
    address = Column(String())
    area = Column(DECIMAL())
