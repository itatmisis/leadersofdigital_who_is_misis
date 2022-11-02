import pyproj

CRS_MSK = 'MSK'
CRS_WGS = 'WGS84'

class UnknownCoordinateReferenceSystem(Exception):
    pass

class CoordConverter:

    def __init__(self):
        self.msk_proj = pyproj.CRS.from_proj4("+proj=tmerc +lat_0=55.66666666667 +lon_0=37.5 +k=1 +x_0=11.86143 +y_0=12.1761150 +ellps=bessel +towgs84=316.151,78.924,589.65,-1.57273,2.69209,2.34693,8.4507 +units=m +no_defs")
        self.wgs84_proj = pyproj.CRS.from_proj4("+proj=longlat +datum=WGS84 +no_defs")
    
    # note: wgs84 - format used in google maps
    def _from_msk_to_wgs84(self, x, y):
        return pyproj.transform(self.msk_proj, self.wgs84_proj, x, y)
    
    def _from_wgs84_to_msk(self, x, y):
        return pyproj.transform(self.wgs84_proj, self.msk_proj, x, y)
    
    def transform(self, x, y, from_):
        if from_ == CRS_MSK:
            return self._from_msk_to_wgs84(x, y)
        elif from_ == CRS_WGS:
            return self._from_wgs84_to_msk(x, y)
        else:
            raise UnknownCoordinateReferenceSystem('There is no CRS named {}, use backend.tools.CRS_MSK or backend.tools.CRS_WGS'.format(from_))
