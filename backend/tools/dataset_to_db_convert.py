import os

from shapely import geometry, wkt
import shapefile
from backend import app, db
from backend.data.models import Land

DATASET_PATHS = {
    "lands": "ЗУ/Земельные_участки.shp",
    "capital": "ОКС/ОКС.shp",
    "organizations": "Организации СВАО_САО/Организации_СВАО_САО.shp",
    "start_grounds": "Стартовые площадки/Стартовые_площадки_реновации.shp",
    "cultural_inheritance": "Территории объектов культурного наследия/Территории_объектов_культурного_наследия.shp"
}
TRUNCATE_TABLE = "TRUNCATE TABLE {}"


def main(path_to_dataset):
    load_lands(path_to_dataset)


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
    db.session.commit()


def load_capital():  # ОКС
    pass


def load_organizations():  # Организации СВАО_САО
    pass


def load_protected_zones():  # Санитарно-защитные зоны
    pass


def load_start_grounds():  # Стартовые площадки
    pass


def load_cultural_inheritance():  # Территории объектов культурного наследия
    pass
