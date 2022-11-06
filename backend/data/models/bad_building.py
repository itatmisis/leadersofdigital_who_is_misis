from sqlalchemy import Column, String, Boolean

from backend import db


class BadBuilding(db.Model):
    __tablename__ = "bad_buildings"

    cadnum = Column(String(80), primary_key=True)
    district = Column(String(20))
    unauthorized = Column(Boolean)
    mismatch = Column(Boolean)
    hazardous = Column(Boolean)
