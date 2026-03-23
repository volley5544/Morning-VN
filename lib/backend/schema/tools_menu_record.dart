import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ToolsMenuRecord extends FirestoreRecord {
  ToolsMenuRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  bool hasIcon() => _icon != null;

  // "icon_blur_hash" field.
  String? _iconBlurHash;
  String get iconBlurHash => _iconBlurHash ?? '';
  bool hasIconBlurHash() => _iconBlurHash != null;

  // "link_url" field.
  String? _linkUrl;
  String get linkUrl => _linkUrl ?? '';
  bool hasLinkUrl() => _linkUrl != null;

  // "param_type" field.
  String? _paramType;
  String get paramType => _paramType ?? '';
  bool hasParamType() => _paramType != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  // "open_type" field.
  String? _openType;
  String get openType => _openType ?? '';
  bool hasOpenType() => _openType != null;

  // "name_vn" field.
  String? _nameVn;
  String get nameVn => _nameVn ?? '';
  bool hasNameVn() => _nameVn != null;

  // "name_th" field.
  String? _nameTh;
  String get nameTh => _nameTh ?? '';
  bool hasNameTh() => _nameTh != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _icon = snapshotData['icon'] as String?;
    _iconBlurHash = snapshotData['icon_blur_hash'] as String?;
    _linkUrl = snapshotData['link_url'] as String?;
    _paramType = snapshotData['param_type'] as String?;
    _order = castToType<int>(snapshotData['order']);
    _openType = snapshotData['open_type'] as String?;
    _nameVn = snapshotData['name_vn'] as String?;
    _nameTh = snapshotData['name_th'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ToolsMenu');

  static Stream<ToolsMenuRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ToolsMenuRecord.fromSnapshot(s));

  static Future<ToolsMenuRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ToolsMenuRecord.fromSnapshot(s));

  static ToolsMenuRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ToolsMenuRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ToolsMenuRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ToolsMenuRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ToolsMenuRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ToolsMenuRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createToolsMenuRecordData({
  String? name,
  String? icon,
  String? iconBlurHash,
  String? linkUrl,
  String? paramType,
  int? order,
  String? openType,
  String? nameVn,
  String? nameTh,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'icon': icon,
      'icon_blur_hash': iconBlurHash,
      'link_url': linkUrl,
      'param_type': paramType,
      'order': order,
      'open_type': openType,
      'name_vn': nameVn,
      'name_th': nameTh,
    }.withoutNulls,
  );

  return firestoreData;
}

class ToolsMenuRecordDocumentEquality implements Equality<ToolsMenuRecord> {
  const ToolsMenuRecordDocumentEquality();

  @override
  bool equals(ToolsMenuRecord? e1, ToolsMenuRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.icon == e2?.icon &&
        e1?.iconBlurHash == e2?.iconBlurHash &&
        e1?.linkUrl == e2?.linkUrl &&
        e1?.paramType == e2?.paramType &&
        e1?.order == e2?.order &&
        e1?.openType == e2?.openType &&
        e1?.nameVn == e2?.nameVn &&
        e1?.nameTh == e2?.nameTh;
  }

  @override
  int hash(ToolsMenuRecord? e) => const ListEquality().hash([
        e?.name,
        e?.icon,
        e?.iconBlurHash,
        e?.linkUrl,
        e?.paramType,
        e?.order,
        e?.openType,
        e?.nameVn,
        e?.nameTh
      ]);

  @override
  bool isValidKey(Object? o) => o is ToolsMenuRecord;
}
