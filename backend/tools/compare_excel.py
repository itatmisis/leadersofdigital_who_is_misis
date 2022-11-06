from backend import db
from backend.data.models import BadBuilding, Building

def compare_tables(table1, table2, *columns):
    intersect = "SELECT {2} from {0} INTERSECT SELECT {2} from {1}"
    res = db.session.execute(intersect.format(table1, table2, ', '.join(columns)))
    return res
