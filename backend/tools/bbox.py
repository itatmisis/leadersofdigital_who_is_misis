import shapely.geometry

from backend.services.polygons import serialize_point


class Bbox:
    polygon: shapely.geometry.Polygon

    def __init__(self, x1, y1, x2, y2):
        self.polygon = shapely.geometry.box(x1, y1, x2, y2)
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2

    def __repr__(self):
        return f"bbox ({self.x1, self.y1}), ({self.x2, self.y2})"

    def coords(self):
        return self.x1, self.y1, self.x2, self.y2

    def to_json(self):
        return {
            "bottom_left": serialize_point(shapely.geometry.Point(self.x1, self.y1)),
            "top_right": serialize_point(shapely.geometry.Point(self.x2, self.y2))
        }


ENTIRE_MAP_BBOX = Bbox(55.474340, 37.157298, 55.959610, 38.011485)
