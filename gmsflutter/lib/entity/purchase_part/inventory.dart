class Inventory {
  int? id;
  int? quantity;
  String? categoryName;

  Inventory({this.id, this.quantity, this.categoryName});

  Inventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
