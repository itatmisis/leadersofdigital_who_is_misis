from sqlalchemy import Integer, Column, Boolean, ForeignKey, orm

from backend import db


class ExtendedLand(db.Model):
    __tablename__ = "extended_lands"

    id = Column(Integer, primary_key=True, autoincrement=True)

    is_sanitary_protected_zone = Column(Boolean)
    is_cultural_heritage = Column(Boolean)

    is_unauthorized = Column(Boolean)
    is_mismatch = Column(Boolean)
    is_hazardous = Column(Boolean)

    land_oid = Column(Integer, ForeignKey("lands.oid"), nullable=True)
    start_ground_oid = Column(Integer, ForeignKey("start_grounds.oid"), nullable=True)

    land = orm.relationship("Land", foreign_keys=[land_oid])
    start_ground = orm.relationship("StartGround", foreign_keys=[start_ground_oid])

    capital_construction_works_objects = orm.relationship("ExtendedCapitalConstructionWorks", backref="extended_land_id")
