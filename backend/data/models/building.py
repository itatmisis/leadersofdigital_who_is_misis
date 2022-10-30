from sqlalchemy import Column, Integer, String, Boolean, DECIMAL

from backend import db


class Building(db.Model):
    __tablename__ = "buildings"

    cadnum = Column(String(80), primary_key=True)
    address = Column(String(255), index=True)
    area = Column(DECIMAL(19))
    habitable = Column(Boolean)
    year_built = Column(Integer)
    wall_material = Column(String(255))
    hazardous = Column(Boolean)
    typical = Column(Boolean)
