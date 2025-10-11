class Buyer {
  int? id;
  String? name;
  String? country;
  String? contactPerson;
  String? phone;
  String? email;
  String? address;
  String? website;

  Buyer(
      {this.id,
        this.name,
        this.country,
        this.contactPerson,
        this.phone,
        this.email,
        this.address,
        this.website});

  Buyer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    contactPerson = json['contactPerson'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['contactPerson'] = this.contactPerson;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['website'] = this.website;
    return data;
  }
}