// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrackingEmployeeDataLocationModelStruct extends FFFirebaseStruct {
  TrackingEmployeeDataLocationModelStruct({
    String? date,
    int? totals,
    List<DataStruct>? data,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _totals = totals,
        _data = data,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "totals" field.
  int? _totals;
  int get totals => _totals ?? 0;
  set totals(int? val) => _totals = val;

  void incrementTotals(int amount) => totals = totals + amount;

  bool hasTotals() => _totals != null;

  // "data" field.
  List<DataStruct>? _data;
  List<DataStruct> get data => _data ?? const [];
  set data(List<DataStruct>? val) => _data = val;

  void updateData(Function(List<DataStruct>) updateFn) {
    updateFn(_data ??= []);
  }

  bool hasData() => _data != null;

  static TrackingEmployeeDataLocationModelStruct fromMap(
          Map<String, dynamic> data) =>
      TrackingEmployeeDataLocationModelStruct(
        date: data['date'] as String?,
        totals: castToType<int>(data['totals']),
        data: getStructList(
          data['data'],
          DataStruct.fromMap,
        ),
      );

  static TrackingEmployeeDataLocationModelStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? TrackingEmployeeDataLocationModelStruct.fromMap(
              data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'totals': _totals,
        'data': _data?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'totals': serializeParam(
          _totals,
          ParamType.int,
        ),
        'data': serializeParam(
          _data,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TrackingEmployeeDataLocationModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TrackingEmployeeDataLocationModelStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        totals: deserializeParam(
          data['totals'],
          ParamType.int,
          false,
        ),
        data: deserializeStructParam<DataStruct>(
          data['data'],
          ParamType.DataStruct,
          true,
          structBuilder: DataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TrackingEmployeeDataLocationModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TrackingEmployeeDataLocationModelStruct &&
        date == other.date &&
        totals == other.totals &&
        listEquality.equals(data, other.data);
  }

  @override
  int get hashCode => const ListEquality().hash([date, totals, data]);
}

TrackingEmployeeDataLocationModelStruct
    createTrackingEmployeeDataLocationModelStruct({
  String? date,
  int? totals,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
        TrackingEmployeeDataLocationModelStruct(
          date: date,
          totals: totals,
          firestoreUtilData: FirestoreUtilData(
            clearUnsetFields: clearUnsetFields,
            create: create,
            delete: delete,
            fieldValues: fieldValues,
          ),
        );

TrackingEmployeeDataLocationModelStruct?
    updateTrackingEmployeeDataLocationModelStruct(
  TrackingEmployeeDataLocationModelStruct? trackingEmployeeDataLocationModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
        trackingEmployeeDataLocationModel
          ?..firestoreUtilData = FirestoreUtilData(
            clearUnsetFields: clearUnsetFields,
            create: create,
          );

void addTrackingEmployeeDataLocationModelStructData(
  Map<String, dynamic> firestoreData,
  TrackingEmployeeDataLocationModelStruct? trackingEmployeeDataLocationModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (trackingEmployeeDataLocationModel == null) {
    return;
  }
  if (trackingEmployeeDataLocationModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      trackingEmployeeDataLocationModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final trackingEmployeeDataLocationModelData =
      getTrackingEmployeeDataLocationModelFirestoreData(
          trackingEmployeeDataLocationModel, forFieldValue);
  final nestedData = trackingEmployeeDataLocationModelData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      trackingEmployeeDataLocationModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTrackingEmployeeDataLocationModelFirestoreData(
  TrackingEmployeeDataLocationModelStruct? trackingEmployeeDataLocationModel, [
  bool forFieldValue = false,
]) {
  if (trackingEmployeeDataLocationModel == null) {
    return {};
  }
  final firestoreData =
      mapToFirestore(trackingEmployeeDataLocationModel.toMap());

  // Add any Firestore field values
  mapToFirestore(
          trackingEmployeeDataLocationModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<
    Map<String, dynamic>> getTrackingEmployeeDataLocationModelListFirestoreData(
  List<TrackingEmployeeDataLocationModelStruct>?
      trackingEmployeeDataLocationModels,
) =>
    trackingEmployeeDataLocationModels
        ?.map((e) => getTrackingEmployeeDataLocationModelFirestoreData(e, true))
        .toList() ??
    [];
