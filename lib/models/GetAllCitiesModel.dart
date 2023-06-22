class GetAllCitiesModel {
  int? tblCountryID;
  String? cityCode;
  String? cityName;
  String? regionCode;

  GetAllCitiesModel({
    this.tblCountryID,
    this.cityCode,
    this.cityName,
    this.regionCode,
  });

  GetAllCitiesModel.fromJson(Map<String, dynamic> json) {
    tblCountryID = json['TblCountryID'];
    cityCode = json['CityCode'];
    cityName = json['CityName'];
    regionCode = json['RegionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TblCountryID'] = tblCountryID;
    data['CityCode'] = cityCode;
    data['CityName'] = cityName;
    data['RegionCode'] = regionCode;
    return data;
  }
}
