from sqlalchemy import Column, Integer


class BaseSHPModel:
    oid = Column(Integer, primary_key=True)
