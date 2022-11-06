import json
import os.path

from backend import db, app
from backend.data.models import Organization
from backend.data.models.base_polygonal_model import BasePolygonalModel
import shapely.geometry
import geoalchemy2.shape

from backend.services import entities


def get_all_polygons_json(entity: str) -> str:  # returns json-dump
    if not entities.PolygonalEntityManager.is_valid(entity):
        raise ValueError(f"Entity {entity} doesn't exist")

    file_path = os.path.join(app.config["PREPROCESSED_DATA_PATH"], entity + ".json")
    if os.path.exists(file_path):
        with open(file_path) as file:
            return file.read()
    else:
        objects = get_all_polygons(entities.PolygonalEntityManager.get_model(entity))
        data_json = dict()
        data_json[entity] = serialize_polygons(objects)
        with open(file_path, "w") as file:
            dump = json.dumps(data_json)
            file.write(dump)
            return dump


def get_all_polygons(entity: BasePolygonalModel) -> list[BasePolygonalModel]:
    objects = db.session.query(entity).all()
    return objects


def serialize_polygons(objects: list[BasePolygonalModel]):
    data_json = [
        {
            "oid": obj.oid,
            "polygons": [
                list(map(serialize_point, list(map(lambda x: shapely.geometry.Point(*x), polygon.exterior.coords))))
                # for polygon in split_multipoint_by_parts(
                #     geoalchemy2.shape.to_shape(obj.points).geoms,
                #     obj.parts
                # )
                for polygon in geoalchemy2.shape.to_shape(obj.points).geoms
            ]
        } for obj in objects
    ]
    return data_json


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


def get_organizations_json():
    file_path = os.path.join(app.config["PREPROCESSED_DATA_PATH"], "organizations.json")
    if os.path.exists(file_path):
        with open(file_path) as file:
            return file.read()
    else:
        objects = db.session.query(Organization).all()
        data_json = {
            "organizations": [
                {
                    "oid": obj.oid,
                    "point": serialize_point(geoalchemy2.shape.to_shape(obj.point))
                } for obj in objects
            ]
        }
        with open(file_path, "w") as file:
            dump = json.dumps(data_json)
            file.write(dump)
            return dump
