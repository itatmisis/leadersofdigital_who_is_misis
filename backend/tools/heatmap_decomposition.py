import json
import os.path

from backend import app
from backend.services import lands
from backend.tools.bbox import Bbox, ENTIRE_MAP_BBOX


def get_geometry_decomposition(number_of_sections: int, x1, y1, x2, y2) -> list[list[Bbox]]:

    width = x2 - x1
    height = y2 - y1

    section_width = width / number_of_sections
    section_height = height / number_of_sections

    decomposition = []

    for i in range(number_of_sections):
        decomposition.append(list())
        for j in range(number_of_sections):
            decomposition[-1].append(Bbox(x1 + section_width * i,
                                          y1 + section_height * j,
                                          x1 + section_height * (i + 1),
                                          y1 + section_height * (j + 1)))
    return decomposition


def preprocess_heatmap(number_of_sections: int) -> str:  # return json str
    file_path = f"heatmap_{number_of_sections}.json"
    if os.path.exists(os.path.join(app.config["PREPROCESSED_DATA_PATH"], file_path)):
        with open(file_path) as file:
            return file.read()

    decomposition = get_geometry_decomposition(number_of_sections, *ENTIRE_MAP_BBOX.get_coords())

    sections_json = []
    for i in range(number_of_sections):
        for j in range(number_of_sections):
            section = decomposition[i][j]
            extended_lands = lands.select_all_in_bbox(section)
            coeffs = []
            is_sanitary_protected_zone = []
            is_cultural_heritage = []
            is_unauthorized = []
            is_mismatch = []
            is_hazardous = []
            is_habitable = []
            is_oks_hazardous = []
            is_typical = []
            kol_mest = []

            for extended_land in extended_lands:
                coeffs.append(extended_land.land.shape_area)
                is_sanitary_protected_zone.append(int(extended_land.land.is_sanitary_protected_zone))
                is_cultural_heritage.append(int(extended_land.land.is_cultural_heritage))
                is_unauthorized.append(int(extended_land.land.is_unauthorized))
                is_mismatch.append(int(extended_land.land.is_mismatch))
                is_hazardous.append(int(extended_land.land.is_hazardous))

                oks_coeffs = []
                oks_is_habitable = []
                oks_is_hazardous = []
                oks_is_typical = []
                oks_kol_mest = []

                for oks in extended_land.capita_contruction_works_objects:
                    oks_coeffs.append(oks.area)
                    oks_is_habitable.append(int(oks.habitable))
                    oks_is_hazardous.append(int(oks.hazardous))
                    oks_is_typical.append(int(oks.typical))

                    kol_mest = 0
                    for org in oks.organizations:
                        kol_mest += org.organization.kol_mest
                    oks_kol_mest.append(kol_mest)

                is_habitable.append(weighted_average(oks_is_habitable, oks_coeffs))
                is_oks_hazardous.append(weighted_average(oks_is_hazardous, oks_coeffs))
                is_typical.append(weighted_average(oks_is_typical, oks_coeffs))
                kol_mest.append(weighted_average(oks_kol_mest, oks_coeffs))

            is_sanitary_protected_zone = weighted_average(is_sanitary_protected_zone, coeffs)
            is_cultural_heritage = weighted_average(is_cultural_heritage, coeffs)
            is_unauthorized = weighted_average(is_unauthorized, coeffs)
            is_mismatch = weighted_average(is_mismatch, coeffs)
            is_hazardous = weighted_average(is_hazardous, coeffs)
            is_habitable = weighted_average(is_habitable, coeffs)
            is_oks_hazardous = weighted_average(is_oks_hazardous, coeffs)
            is_typical = weighted_average(is_typical, coeffs)
            kol_mest = weighted_average(kol_mest, coeffs)

            sections_json.append({
                "bbox": section.to_json(),
                "average_data": {
                    "is_sanitary_protected_zone": is_sanitary_protected_zone,
                    "is_cultural_heritage": is_cultural_heritage,
                    "is_unauthorized": is_unauthorized,
                    "is_mismatch": is_mismatch,
                    "is_hazardous": is_hazardous,
                    "is_habitable": is_habitable,
                    "is_oks_hazardous": is_oks_hazardous,
                    "is_typical": is_typical,
                    "kol_mest": kol_mest
                }
            })

    data_json = {
        "heatmap": {
            "number_of_sections": number_of_sections,
            "sections": sections_json
        }
    }
    with open(file_path, "w") as file:
        dump = json.dumps(data_json)
        file.write(dump)
        return dump


def weighted_average(values, coeffs):
    if (len(values)) != len(coeffs):
        raise ValueError
    return sum(map(lambda x: x[0] * x[1], zip(values, coeffs))) / sum(coeffs)
