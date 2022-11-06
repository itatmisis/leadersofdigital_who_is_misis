from backend.data.models import *
from backend.data.models.base_polygonal_model import BasePolygonalModel


class PolygonalEntityManager:
    _ENTITIES = {
        Land.__tablename__: Land,
        CapitalConstructionWorks.__tablename__: CapitalConstructionWorks,
        CulturalHeritage.__tablename__: CulturalHeritage,
        SanitaryProtectedZone.__tablename__: SanitaryProtectedZone,
        StartGround.__tablename__: StartGround
    }

    @staticmethod
    def get_model(entity: str) -> BasePolygonalModel:
        return PolygonalEntityManager._ENTITIES[entity]

    @staticmethod
    def is_valid(entity: str) -> bool:
        return entity in PolygonalEntityManager._ENTITIES
