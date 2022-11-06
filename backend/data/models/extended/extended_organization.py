from sqlalchemy import Integer, Column, ForeignKey, orm

from backend import db


class ExtendedOrganization(db.Model):
    __tablename__ = "extended_organizations"

    oid = Column(Integer, ForeignKey("organizations.oid", ondelete='CASCADE'), primary_key=True)

    organization = orm.relationship("Organization", foreign_keys=[oid])
    extended_capital_construction_works_oid = Column(Integer, ForeignKey("extended_capital_construction_works.oid",
                                                                         ondelete='CASCADE'), nullable=True)

    extended_capital_construction_works = orm.relationship("ExtendedCapitalConstructionWorks",
                                                           foreign_keys=[extended_capital_construction_works_oid])