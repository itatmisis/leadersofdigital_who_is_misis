import os

import openpyxl
import shapely.geometry
from shapely import geometry, wkt
import shapefile
from backend import db
from backend.data.models import Land, BadBuilding, Building, Organization

DATASET_PATHS = {
    "lands": "ЗУ/Земельные_участки.shp",
    "capital": "ОКС/ОКС.shp",
    "organizations": "Организации СВАО_САО/Организации_СВАО_САО.shp",
    "start_grounds": "Стартовые площадки/Стартовые_площадки_реновации.shp",
    "cultural_inheritance": "Территории объектов культурного наследия/Территории_объектов_культурного_наследия.shp",
    "bad_records": "Аварийные_Самовольные_Несоответствие_ВРИ_СВАО_САО.xlsx",
    "buildings": "Здания СВАО_САО жилое_нежилое.xlsx"
}
TRUNCATE_TABLE = "TRUNCATE TABLE {}"
YES = "Да"
HABITABLE_STR = "жилое"


def main(path_to_dataset):
    load_lands(path_to_dataset)
    load_organizations(path_to_dataset)
    load_bad_buildings(path_to_dataset)
    load_buildings(path_to_dataset)

    db.session.commit()


def load_lands(path_to_dataset):  # ЗУ
    db.session.execute(TRUNCATE_TABLE.format(Land.__tablename__))

    reader = shapefile.Reader(os.path.join(path_to_dataset, DATASET_PATHS["lands"]), encoding="cp1251")
    for shaperec in reader.shapeRecords():
        obj = Land(
            oid=shaperec.shape.oid,
            shapetype=shaperec.shape.shapeType,
            parts=list(shaperec.shape.parts),
            points=wkt.dumps(geometry.MultiPoint(shaperec.shape.points)),
            bbox=wkt.dumps(geometry.box(*shaperec.shape.bbox)),

            cadnum=shaperec.record.DESCR,
            address=shaperec.record.ADDRESS,
            has_effect=shaperec.record.HAS_EFFECT,
            property_t=shaperec.record.PROPERTY_T,
            shape_area=shaperec.record.SHAPE_AREA
        )
        db.session.add(obj)
    reader.close()


def load_capital():  # ОКС
    pass


def load_organizations(path_to_dataset):  # Организации СВАО_САО
    db.session.execute(TRUNCATE_TABLE.format(Land.__tablename__))

    reader = shapefile.Reader(os.path.join(path_to_dataset, DATASET_PATHS["organizations"]), encoding="cp1251")
    for shaperec in reader.shapeRecords():
        org = Organization(
            oid=shaperec.shape.oid,
            point=wkt.dumps(geometry.Point(*shaperec.shape.points[0])),

            name=shaperec.record.name,
            kol_mest=shaperec.record.kol_mest
        )
        db.session.add(org)
    reader.close()


def load_protected_zones():  # Санитарно-защитные зоны
    pass


def load_start_grounds():  # Стартовые площадки
    pass


def load_cultural_inheritance():  # Территории объектов культурного наследия
    pass


def load_bad_buildings(path_to_dataset):
    db.session.execute(TRUNCATE_TABLE.format(BadBuilding.__tablename__))

    wb = openpyxl.load_workbook(filename=os.path.join(path_to_dataset, DATASET_PATHS["bad_records"]))
    ws = wb.active
    for row in ws.iter_rows(min_row=2, values_only=True):
        district, cadnum, unauthorized, mismatch, hazardous = row
        bad_building = BadBuilding(
            cadnum=cadnum,
            district=district,
            unauthorized=unauthorized == YES,
            mismatch=mismatch == YES,
            hazardous=hazardous == YES,
        )
        db.session.merge(bad_building)
    wb.close()


def load_buildings(path_to_dataset):
    db.session.execute(TRUNCATE_TABLE.format(Building.__tablename__))

    wb = openpyxl.load_workbook(filename=os.path.join(path_to_dataset, DATASET_PATHS["buildings"]))
    ws = wb.active
    for row in ws.iter_rows(min_row=2, values_only=True):
        cadnum, address, area, habitable, year_built, wall_material, hazardous, typical = row
        if year_built == '' or year_built == 0:
            year_built = None

        bad_building = Building(
            cadnum=cadnum,
            address=address,
            area=area,
            habitable=habitable == HABITABLE_STR,
            year_built=year_built,
            wall_material=wall_material,
            hazardous=hazardous == YES,
            typical=typical == YES
        )
        db.session.merge(bad_building)
    wb.close()
