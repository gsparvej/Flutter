class Vendor {
  int? id;
  String? vendorName;
  String? companyName;
  String? contactPerson;
  String? email;
  String? phone;
  String? address;
  String? tin;
  String? bin;
  String? vat;

  Vendor({
    this.id,
    this.vendorName,
    this.companyName,
    this.contactPerson,
    this.email,
    this.phone,
    this.address,
    this.tin,
    this.bin,
    this.vat,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as int?,
      vendorName: (json['vendorName'] as String?)?.trim(),
      companyName: (json['companyName'] as String?)?.trim(),
      contactPerson: (json['contactPerson'] as String?)?.trim(),
      email: (json['email'] as String?)?.trim(),
      phone: (json['phone'] as String?)?.trim(),
      address: (json['address'] as String?)?.trim(),
      tin: (json['tin'] as String?)?.trim(),
      bin: (json['bin'] as String?)?.trim(),
      vat: (json['vat'] as String?)?.trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorName': vendorName,
      'companyName': companyName,
      'contactPerson': contactPerson,
      'email': email,
      'phone': phone,
      'address': address,
      'tin': tin,
      'bin': bin,
      'vat': vat,
    };
  }
}
