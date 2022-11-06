from sqlalchemy import Integer, Column, ForeignKey

from backend import db


class ExtendedOrganization(db.Model):
    __tablename__ = "extended_organizations"

    oid = Column(Integer, ForeignKey("organizations.oid", ondelete='CASCADE'), primary_key=True)
    extended_capital_construction_works_oid = Column(Integer, ForeignKey("extended_capital_construction_works.oid", ondelete='CASCADE'), nullable=True)
