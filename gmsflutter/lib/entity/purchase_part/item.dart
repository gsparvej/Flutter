class Item {
  int? id;
  String? categoryName;
  String? unit;

  Item({this.id, this.categoryName, this.unit});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['unit'] = this.unit;
    return data;
  }
}
