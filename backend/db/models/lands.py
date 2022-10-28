import shapefile
from sqlalchemy import Column, Integer, String, Enum, DECIMAL
from sqlalchemy.dialects.postgresql import ARRAY

from backend import db




class Land(db.Model):
    __tablename__ = "lands"

    id = Column(Integer, primary_key=True, autoincrement=True)

    oid = Column(Integer, nullable=True)
    shapetype = Column(Integer, Enum(shapefile.SHAPETYPE_LOOKUP))
    parts = Column(ARRAY(Integer))
    points = Column(ARRAY(DECIMAL()))