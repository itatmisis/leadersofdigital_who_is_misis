from sqlalchemy import Column, Integer, ForeignKey, Boolean, DECIMAL, String

from backend import db


class ExtendedCapitalConstructionWorks(db.Model):
    __tablename__ = "extended_capital_construction_works"

    oid = Column(Integer, ForeignKey("capital_construction_works.oid"), primary_key=True)
    habitable = Column(Boolean)
    area = Column(DECIMAL(19))
    year_built = Column(Integer)
    wall_material = Column(String(255))
    hazardous = Column(Boolean)
    typical = Column(Boolean)

    extended_land_id = Column(Integer, ForeignKey("ExtendedLand"), backref="capital_construction_works_objects")
