class Subdistrict {
  String? name;
  String? zipcode;

  Subdistrict({
    this.name,
    this.zipcode,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'zipcode': zipcode});

    return result;
  }


  factory Subdistrict.fromJson(Map<String, dynamic> json) {
    return Subdistrict(
      name: json['name'] ?? '',
      zipcode: json['zipcode'] ?? '',
    );
  }
}
