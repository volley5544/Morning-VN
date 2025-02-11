import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoleMenuRecord extends FirestoreRecord {
  RoleMenuRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "menuName" field.
  List<String>? _menuName;
  List<String> get menuName => _menuName ?? const [];
  bool hasMenuName() => _menuName != null;

  // "menuHo" field.
  List<bool>? _menuHo;
  List<bool> get menuHo => _menuHo ?? const [];
  bool hasMenuHo() => _menuHo != null;

  // "menuBranch" field.
  List<bool>? _menuBranch;
  List<bool> get menuBranch => _menuBranch ?? const [];
  bool hasMenuBranch() => _menuBranch != null;

  // "menuGBM" field.
  List<bool>? _menuGBM;
  List<bool> get menuGBM => _menuGBM ?? const [];
  bool hasMenuGBM() => _menuGBM != null;

  // "menuASM" field.
  List<bool>? _menuASM;
  List<bool> get menuASM => _menuASM ?? const [];
  bool hasMenuASM() => _menuASM != null;

  // "menuAssistant" field.
  List<bool>? _menuAssistant;
  List<bool> get menuAssistant => _menuAssistant ?? const [];
  bool hasMenuAssistant() => _menuAssistant != null;

  void _initializeFields() {
    _menuName = getDataList(snapshotData['menuName']);
    _menuHo = getDataList(snapshotData['menuHo']);
    _menuBranch = getDataList(snapshotData['menuBranch']);
    _menuGBM = getDataList(snapshotData['menuGBM']);
    _menuASM = getDataList(snapshotData['menuASM']);
    _menuAssistant = getDataList(snapshotData['menuAssistant']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('role_menu');

  static Stream<RoleMenuRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoleMenuRecord.fromSnapshot(s));

  static Future<RoleMenuRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoleMenuRecord.fromSnapshot(s));

  static RoleMenuRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RoleMenuRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoleMenuRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoleMenuRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoleMenuRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoleMenuRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoleMenuRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class RoleMenuRecordDocumentEquality implements Equality<RoleMenuRecord> {
  const RoleMenuRecordDocumentEquality();

  @override
  bool equals(RoleMenuRecord? e1, RoleMenuRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.menuName, e2?.menuName) &&
        listEquality.equals(e1?.menuHo, e2?.menuHo) &&
        listEquality.equals(e1?.menuBranch, e2?.menuBranch) &&
        listEquality.equals(e1?.menuGBM, e2?.menuGBM) &&
        listEquality.equals(e1?.menuASM, e2?.menuASM) &&
        listEquality.equals(e1?.menuAssistant, e2?.menuAssistant);
  }

  @override
  int hash(RoleMenuRecord? e) => const ListEquality().hash([
        e?.menuName,
        e?.menuHo,
        e?.menuBranch,
        e?.menuGBM,
        e?.menuASM,
        e?.menuAssistant
      ]);

  @override
  bool isValidKey(Object? o) => o is RoleMenuRecord;
}
