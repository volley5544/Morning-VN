import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class KeyStorage1Record extends FirestoreRecord {
  KeyStorage1Record._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "api_url" field.
  String? _apiUrl;
  String get apiUrl => _apiUrl ?? '';
  bool hasApiUrl() => _apiUrl != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _apiUrl = snapshotData['api_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('KeyStorage1');

  static Stream<KeyStorage1Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => KeyStorage1Record.fromSnapshot(s));

  static Future<KeyStorage1Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => KeyStorage1Record.fromSnapshot(s));

  static KeyStorage1Record fromSnapshot(DocumentSnapshot snapshot) =>
      KeyStorage1Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static KeyStorage1Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      KeyStorage1Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'KeyStorage1Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is KeyStorage1Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createKeyStorage1RecordData({
  String? name,
  String? apiUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'api_url': apiUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class KeyStorage1RecordDocumentEquality implements Equality<KeyStorage1Record> {
  const KeyStorage1RecordDocumentEquality();

  @override
  bool equals(KeyStorage1Record? e1, KeyStorage1Record? e2) {
    return e1?.name == e2?.name && e1?.apiUrl == e2?.apiUrl;
  }

  @override
  int hash(KeyStorage1Record? e) =>
      const ListEquality().hash([e?.name, e?.apiUrl]);

  @override
  bool isValidKey(Object? o) => o is KeyStorage1Record;
}
