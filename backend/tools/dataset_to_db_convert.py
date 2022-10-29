import shapefile
from backend import app, db
from backend.db.models import *

def main():
    pass


def load_lands():  # ЗУ
    pass


def load_capital(path):  # ОКС
    sf = shapefile.Reader(path, encoding='cp1251')
    for index, elem in enumerate(sf.shapes()):
        fields = {
            'oid': elem.oid,
            'shapetype': elem.shapeType,
            'parts': elem.parts,
            'points': elem.points,
            'bbox': elem.bbox,

            'cadnum': sf.records()[index].cadnum,
            'address': sf.records()[index].address,
            'area': sf.records()[index].Area,
        }
        construction = ConstructionWorks(**fields)
        db.session.add(construction)
        db.session.commit()


def load_organizations():  # Организации СВАО_САО
    pass


def load_start_grounds():  # Стартовые площадки
    pass


def load_cultural_inheritance():  # Территории объектов культурного наследия
    pass

