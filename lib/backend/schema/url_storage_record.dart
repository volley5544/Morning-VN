import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UrlStorageRecord extends FirestoreRecord {
  UrlStorageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "collection_vn" field.
  String? _collectionVn;
  String get collectionVn => _collectionVn ?? '';
  bool hasCollectionVn() => _collectionVn != null;

  void _initializeFields() {
    _collectionVn = snapshotData['collection_vn'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('urlStorage');

  static Stream<UrlStorageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UrlStorageRecord.fromSnapshot(s));

  static Future<UrlStorageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UrlStorageRecord.fromSnapshot(s));

  static UrlStorageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UrlStorageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UrlStorageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UrlStorageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UrlStorageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UrlStorageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUrlStorageRecordData({
  String? collectionVn,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'collection_vn': collectionVn,
    }.withoutNulls,
  );

  return firestoreData;
}

class UrlStorageRecordDocumentEquality implements Equality<UrlStorageRecord> {
  const UrlStorageRecordDocumentEquality();

  @override
  bool equals(UrlStorageRecord? e1, UrlStorageRecord? e2) {
    return e1?.collectionVn == e2?.collectionVn;
  }

  @override
  int hash(UrlStorageRecord? e) => const ListEquality().hash([e?.collectionVn]);

  @override
  bool isValidKey(Object? o) => o is UrlStorageRecord;
}
