from backend import db
from backend.data.models.base_polygonal_model import BasePolygonalModel
import shapely.geometry
import geoalchemy2.shape

from backend.services import entities


def get_all_polygons(entity: str) -> list[BasePolygonalModel]:
    if not entities.PolygonalEntityManager.is_valid(entity):
        raise ValueError(f"Entity {entity} doesn't exist")

    objects = db.session.query(entities.PolygonalEntityManager.get_model(entity)).all()
    return objects


def serialize_polygons(objects: list[BasePolygonalModel]):
    json = [
        {
            "oid": obj.oid,
            "polygons": [
                list(map(serialize_point, polygon))
                for polygon in split_multipoint_by_parts(
                    geoalchemy2.shape.to_shape(obj.points).geoms,
                    obj.parts
                )
            ]
        } for obj in objects
    ]
    return json


def serialize_point(point: shapely.geometry.Point):
    return {
        "lat": point.x,
        "lon": point.y
    }


def split_multipoint_by_parts(points: list[shapely.geometry.Point], parts: list[int]):
    resp = []

    for i in range(len(parts) - 1):
        resp.append(points[parts[i]:parts[i + 1]])
    resp.append(points[parts[-1]:])
    return resp
