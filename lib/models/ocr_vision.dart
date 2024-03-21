class OcrThaiId {
  final String thaiId;

  OcrThaiId({this.thaiId = ''});

  factory OcrThaiId.fromJson(Map<String, dynamic> json) {
    return new OcrThaiId(thaiId: json['thai_id'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"name": thaiId};
  }
}
