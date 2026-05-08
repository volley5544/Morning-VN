// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConfigRP8ModelStruct extends FFFirebaseStruct {
  ConfigRP8ModelStruct({
    List<RemarkDropdownRP8ModelStruct>? dropdown,
    String? remarkMaxLength,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _dropdown = dropdown,
        _remarkMaxLength = remarkMaxLength,
        super(firestoreUtilData);

  // "dropdown" field.
  List<RemarkDropdownRP8ModelStruct>? _dropdown;
  List<RemarkDropdownRP8ModelStruct> get dropdown => _dropdown ?? const [];
  set dropdown(List<RemarkDropdownRP8ModelStruct>? val) => _dropdown = val;

  void updateDropdown(Function(List<RemarkDropdownRP8ModelStruct>) updateFn) {
    updateFn(_dropdown ??= []);
  }

  bool hasDropdown() => _dropdown != null;

  // "remark_max_length" field.
  String? _remarkMaxLength;
  String get remarkMaxLength => _remarkMaxLength ?? '';
  set remarkMaxLength(String? val) => _remarkMaxLength = val;

  bool hasRemarkMaxLength() => _remarkMaxLength != null;

  static ConfigRP8ModelStruct fromMap(Map<String, dynamic> data) =>
      ConfigRP8ModelStruct(
        dropdown: getStructList(
          data['dropdown'],
          RemarkDropdownRP8ModelStruct.fromMap,
        ),
        remarkMaxLength: data['remark_max_length'] as String?,
      );

  static ConfigRP8ModelStruct? maybeFromMap(dynamic data) => data is Map
      ? ConfigRP8ModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'dropdown': _dropdown?.map((e) => e.toMap()).toList(),
        'remark_max_length': _remarkMaxLength,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'dropdown': serializeParam(
          _dropdown,
          ParamType.DataStruct,
          isList: true,
        ),
        'remark_max_length': serializeParam(
          _remarkMaxLength,
          ParamType.String,
        ),
      }.withoutNulls;

  static ConfigRP8ModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConfigRP8ModelStruct(
        dropdown: deserializeStructParam<RemarkDropdownRP8ModelStruct>(
          data['dropdown'],
          ParamType.DataStruct,
          true,
          structBuilder: RemarkDropdownRP8ModelStruct.fromSerializableMap,
        ),
        remarkMaxLength: deserializeParam(
          data['remark_max_length'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ConfigRP8ModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ConfigRP8ModelStruct &&
        listEquality.equals(dropdown, other.dropdown) &&
        remarkMaxLength == other.remarkMaxLength;
  }

  @override
  int get hashCode => const ListEquality().hash([dropdown, remarkMaxLength]);
}

ConfigRP8ModelStruct createConfigRP8ModelStruct({
  String? remarkMaxLength,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConfigRP8ModelStruct(
      remarkMaxLength: remarkMaxLength,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConfigRP8ModelStruct? updateConfigRP8ModelStruct(
  ConfigRP8ModelStruct? configRP8Model, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    configRP8Model
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConfigRP8ModelStructData(
  Map<String, dynamic> firestoreData,
  ConfigRP8ModelStruct? configRP8Model,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (configRP8Model == null) {
    return;
  }
  if (configRP8Model.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && configRP8Model.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final configRP8ModelData =
      getConfigRP8ModelFirestoreData(configRP8Model, forFieldValue);
  final nestedData =
      configRP8ModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = configRP8Model.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConfigRP8ModelFirestoreData(
  ConfigRP8ModelStruct? configRP8Model, [
  bool forFieldValue = false,
]) {
  if (configRP8Model == null) {
    return {};
  }
  final firestoreData = mapToFirestore(configRP8Model.toMap());

  // Add any Firestore field values
  mapToFirestore(configRP8Model.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConfigRP8ModelListFirestoreData(
  List<ConfigRP8ModelStruct>? configRP8Models,
) =>
    configRP8Models
        ?.map((e) => getConfigRP8ModelFirestoreData(e, true))
        .toList() ??
    [];
