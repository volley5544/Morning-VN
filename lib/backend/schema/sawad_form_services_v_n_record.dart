import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SawadFormServicesVNRecord extends FirestoreRecord {
  SawadFormServicesVNRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "form_service_img" field.
  String? _formServiceImg;
  String get formServiceImg => _formServiceImg ?? '';
  bool hasFormServiceImg() => _formServiceImg != null;

  // "form_service_name" field.
  String? _formServiceName;
  String get formServiceName => _formServiceName ?? '';
  bool hasFormServiceName() => _formServiceName != null;

  // "form_service_order" field.
  int? _formServiceOrder;
  int get formServiceOrder => _formServiceOrder ?? 0;
  bool hasFormServiceOrder() => _formServiceOrder != null;

  // "form_service_url" field.
  String? _formServiceUrl;
  String get formServiceUrl => _formServiceUrl ?? '';
  bool hasFormServiceUrl() => _formServiceUrl != null;

  void _initializeFields() {
    _formServiceImg = snapshotData['form_service_img'] as String?;
    _formServiceName = snapshotData['form_service_name'] as String?;
    _formServiceOrder = castToType<int>(snapshotData['form_service_order']);
    _formServiceUrl = snapshotData['form_service_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('SawadFormServicesVN');

  static Stream<SawadFormServicesVNRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SawadFormServicesVNRecord.fromSnapshot(s));

  static Future<SawadFormServicesVNRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => SawadFormServicesVNRecord.fromSnapshot(s));

  static SawadFormServicesVNRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SawadFormServicesVNRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SawadFormServicesVNRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SawadFormServicesVNRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SawadFormServicesVNRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SawadFormServicesVNRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSawadFormServicesVNRecordData({
  String? formServiceImg,
  String? formServiceName,
  int? formServiceOrder,
  String? formServiceUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'form_service_img': formServiceImg,
      'form_service_name': formServiceName,
      'form_service_order': formServiceOrder,
      'form_service_url': formServiceUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class SawadFormServicesVNRecordDocumentEquality
    implements Equality<SawadFormServicesVNRecord> {
  const SawadFormServicesVNRecordDocumentEquality();

  @override
  bool equals(SawadFormServicesVNRecord? e1, SawadFormServicesVNRecord? e2) {
    return e1?.formServiceImg == e2?.formServiceImg &&
        e1?.formServiceName == e2?.formServiceName &&
        e1?.formServiceOrder == e2?.formServiceOrder &&
        e1?.formServiceUrl == e2?.formServiceUrl;
  }

  @override
  int hash(SawadFormServicesVNRecord? e) => const ListEquality().hash([
        e?.formServiceImg,
        e?.formServiceName,
        e?.formServiceOrder,
        e?.formServiceUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is SawadFormServicesVNRecord;
}
