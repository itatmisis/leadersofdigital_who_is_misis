from sqlalchemy import Column, Integer, ForeignKey, Boolean, DECIMAL, String, orm

from backend import db


class ExtendedCapitalConstructionWorks(db.Model):
    __tablename__ = "extended_capital_construction_works"

    oid = Column(Integer, ForeignKey("capital_construction_works.oid", ondelete='CASCADE'), primary_key=True)
    habitable = Column(Boolean)
    area = Column(DECIMAL(19))
    year_built = Column(Integer)
    wall_material = Column(String(255))
    hazardous = Column(Boolean)
    typical = Column(Boolean)

    extended_land_id = Column(Integer, ForeignKey("extended_lands.id", ondelete='CASCADE'))

    extended_organizations = orm.relationship("ExtendedOrganization", backref="extended_capital_construction_works")
    # extended_land = orm.relationship("ExtendedLand", foreign_keys=[extended_land_id])
