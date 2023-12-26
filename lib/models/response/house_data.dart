class HouseData {
  var id;
  var houseNo;
  var datetime;

  HouseData({this.id, this.houseNo, this.datetime});

  HouseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseNo = json['house_no'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['house_no'] = houseNo;
    data['datetime'] = datetime;
    return data;
  }
}
