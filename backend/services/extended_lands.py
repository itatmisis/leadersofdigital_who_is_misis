from typing import Iterable, Optional
from backend.data.models import ExtendedLand, ExtendedCapitalConstructionWorks, ExtendedOrganization, Land, StartGround

def serialize_extended_lands(objects: Iterable[ExtendedLand]) -> list:
    data_json = [
        { 
            "id": obj.id,

            "land_oid": obj.land_oid,
            "start_ground_oid": obj.start_ground_oid,

            "is_sanitary_protected_zone": obj.is_sanitary_protected_zone,
            "is_cultural_heritage": obj.is_cultural_heritage,

            "is_unauthorized": obj.is_unauthorized,
            "is_mismatch": obj.is_mismatch,
            "is_hazardous": obj.is_hazardous,

            "land": get_land_data(obj.land),
            "start_ground": get_start_ground_data(obj.start_ground),
            "oks_objects": serialize_extended_capital_construction_works(obj.capital_construction_works_objects)
        } for obj in objects
    ]
    return data_json


def serialize_extended_capital_construction_works(objects: Iterable[ExtendedCapitalConstructionWorks]) -> list:
    data_json = [
        {
            'oid': oks_object.oid,
            'habitable': oks_object.habitable,
            'area': oks_object.area,
            'year_built': oks_object.year_built,
            'wall_material': oks_object.wall_material,
            'hazardous': oks_object.hazardous,
            'typical':oks_object.typical,
            'extended_organizations': serialize_extended_organizations(oks_object.extended_organizations)
        } for oks_object in objects
     ]
    return data_json


def serialize_extended_organizations(objects: Iterable[ExtendedOrganization]) -> list:
    data_json = [
        {
            'oid': obj.oid,
            'name': obj.organization.name,
            'kol_mest': obj.organization.kol_mest,
        } for obj in objects
    ]

    return data_json


def get_land_data(land: Optional[Land]) -> dict:
    data = {
        'cadnum': None,
        'address': None,
        'has_effect': None,
        'property_t': None,
        'shape_area': None,
    }
    if land is not None:
        data = {
            'cadnum': land.cadnum,
            'address': land.address,
            'has_effect': land.has_effect,
            'property_t': land.property_t,
            'shape_area': land.shape_area,
        }
    return data

def get_start_ground_data(start_ground: Optional[StartGround]) -> dict:
    data = {
        'cadnum': None,
        'address': None,
        'has_effect': None,
        'property_t': None,
        'shape_area': None,
    }
    if start_ground is not None:
        data = {
            'cadnum': start_ground.district,
            'address': start_ground.address,
        }
    return data
