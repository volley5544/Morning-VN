// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class HistoryCollectionDataModelStruct extends FFFirebaseStruct {
  HistoryCollectionDataModelStruct({
    String? historyCallStatus,
    String? historyCallTime,
    String? historyLeadStatus,
    String? historyReasonName,
    String? ardate,
    String? arappdate,
    String? remgcode,
    String? remdetcode,
    String? ardesc,
    String? channel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _historyCallStatus = historyCallStatus,
        _historyCallTime = historyCallTime,
        _historyLeadStatus = historyLeadStatus,
        _historyReasonName = historyReasonName,
        _ardate = ardate,
        _arappdate = arappdate,
        _remgcode = remgcode,
        _remdetcode = remdetcode,
        _ardesc = ardesc,
        _channel = channel,
        super(firestoreUtilData);

  // "HISTORY_CALL_STATUS" field.
  String? _historyCallStatus;
  String get historyCallStatus => _historyCallStatus ?? '';
  set historyCallStatus(String? val) => _historyCallStatus = val;

  bool hasHistoryCallStatus() => _historyCallStatus != null;

  // "HISTORY_CALL_TIME" field.
  String? _historyCallTime;
  String get historyCallTime => _historyCallTime ?? '';
  set historyCallTime(String? val) => _historyCallTime = val;

  bool hasHistoryCallTime() => _historyCallTime != null;

  // "HISTORY_LEAD_STATUS" field.
  String? _historyLeadStatus;
  String get historyLeadStatus => _historyLeadStatus ?? '';
  set historyLeadStatus(String? val) => _historyLeadStatus = val;

  bool hasHistoryLeadStatus() => _historyLeadStatus != null;

  // "HISTORY_REASON_NAME" field.
  String? _historyReasonName;
  String get historyReasonName => _historyReasonName ?? '';
  set historyReasonName(String? val) => _historyReasonName = val;

  bool hasHistoryReasonName() => _historyReasonName != null;

  // "ARDATE" field.
  String? _ardate;
  String get ardate => _ardate ?? '';
  set ardate(String? val) => _ardate = val;

  bool hasArdate() => _ardate != null;

  // "ARAPPDATE" field.
  String? _arappdate;
  String get arappdate => _arappdate ?? '';
  set arappdate(String? val) => _arappdate = val;

  bool hasArappdate() => _arappdate != null;

  // "REMGCODE" field.
  String? _remgcode;
  String get remgcode => _remgcode ?? '';
  set remgcode(String? val) => _remgcode = val;

  bool hasRemgcode() => _remgcode != null;

  // "REMDETCODE" field.
  String? _remdetcode;
  String get remdetcode => _remdetcode ?? '';
  set remdetcode(String? val) => _remdetcode = val;

  bool hasRemdetcode() => _remdetcode != null;

  // "ARDESC" field.
  String? _ardesc;
  String get ardesc => _ardesc ?? '';
  set ardesc(String? val) => _ardesc = val;

  bool hasArdesc() => _ardesc != null;

  // "CHANNEL" field.
  String? _channel;
  String get channel => _channel ?? '';
  set channel(String? val) => _channel = val;

  bool hasChannel() => _channel != null;

  static HistoryCollectionDataModelStruct fromMap(Map<String, dynamic> data) =>
      HistoryCollectionDataModelStruct(
        historyCallStatus: data['HISTORY_CALL_STATUS'] as String?,
        historyCallTime: data['HISTORY_CALL_TIME'] as String?,
        historyLeadStatus: data['HISTORY_LEAD_STATUS'] as String?,
        historyReasonName: data['HISTORY_REASON_NAME'] as String?,
        ardate: data['ARDATE'] as String?,
        arappdate: data['ARAPPDATE'] as String?,
        remgcode: data['REMGCODE'] as String?,
        remdetcode: data['REMDETCODE'] as String?,
        ardesc: data['ARDESC'] as String?,
        channel: data['CHANNEL'] as String?,
      );

  static HistoryCollectionDataModelStruct? maybeFromMap(dynamic data) => data
          is Map
      ? HistoryCollectionDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'HISTORY_CALL_STATUS': _historyCallStatus,
        'HISTORY_CALL_TIME': _historyCallTime,
        'HISTORY_LEAD_STATUS': _historyLeadStatus,
        'HISTORY_REASON_NAME': _historyReasonName,
        'ARDATE': _ardate,
        'ARAPPDATE': _arappdate,
        'REMGCODE': _remgcode,
        'REMDETCODE': _remdetcode,
        'ARDESC': _ardesc,
        'CHANNEL': _channel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'HISTORY_CALL_STATUS': serializeParam(
          _historyCallStatus,
          ParamType.String,
        ),
        'HISTORY_CALL_TIME': serializeParam(
          _historyCallTime,
          ParamType.String,
        ),
        'HISTORY_LEAD_STATUS': serializeParam(
          _historyLeadStatus,
          ParamType.String,
        ),
        'HISTORY_REASON_NAME': serializeParam(
          _historyReasonName,
          ParamType.String,
        ),
        'ARDATE': serializeParam(
          _ardate,
          ParamType.String,
        ),
        'ARAPPDATE': serializeParam(
          _arappdate,
          ParamType.String,
        ),
        'REMGCODE': serializeParam(
          _remgcode,
          ParamType.String,
        ),
        'REMDETCODE': serializeParam(
          _remdetcode,
          ParamType.String,
        ),
        'ARDESC': serializeParam(
          _ardesc,
          ParamType.String,
        ),
        'CHANNEL': serializeParam(
          _channel,
          ParamType.String,
        ),
      }.withoutNulls;

  static HistoryCollectionDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HistoryCollectionDataModelStruct(
        historyCallStatus: deserializeParam(
          data['HISTORY_CALL_STATUS'],
          ParamType.String,
          false,
        ),
        historyCallTime: deserializeParam(
          data['HISTORY_CALL_TIME'],
          ParamType.String,
          false,
        ),
        historyLeadStatus: deserializeParam(
          data['HISTORY_LEAD_STATUS'],
          ParamType.String,
          false,
        ),
        historyReasonName: deserializeParam(
          data['HISTORY_REASON_NAME'],
          ParamType.String,
          false,
        ),
        ardate: deserializeParam(
          data['ARDATE'],
          ParamType.String,
          false,
        ),
        arappdate: deserializeParam(
          data['ARAPPDATE'],
          ParamType.String,
          false,
        ),
        remgcode: deserializeParam(
          data['REMGCODE'],
          ParamType.String,
          false,
        ),
        remdetcode: deserializeParam(
          data['REMDETCODE'],
          ParamType.String,
          false,
        ),
        ardesc: deserializeParam(
          data['ARDESC'],
          ParamType.String,
          false,
        ),
        channel: deserializeParam(
          data['CHANNEL'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'HistoryCollectionDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HistoryCollectionDataModelStruct &&
        historyCallStatus == other.historyCallStatus &&
        historyCallTime == other.historyCallTime &&
        historyLeadStatus == other.historyLeadStatus &&
        historyReasonName == other.historyReasonName &&
        ardate == other.ardate &&
        arappdate == other.arappdate &&
        remgcode == other.remgcode &&
        remdetcode == other.remdetcode &&
        ardesc == other.ardesc &&
        channel == other.channel;
  }

  @override
  int get hashCode => const ListEquality().hash([
        historyCallStatus,
        historyCallTime,
        historyLeadStatus,
        historyReasonName,
        ardate,
        arappdate,
        remgcode,
        remdetcode,
        ardesc,
        channel
      ]);
}

HistoryCollectionDataModelStruct createHistoryCollectionDataModelStruct({
  String? historyCallStatus,
  String? historyCallTime,
  String? historyLeadStatus,
  String? historyReasonName,
  String? ardate,
  String? arappdate,
  String? remgcode,
  String? remdetcode,
  String? ardesc,
  String? channel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HistoryCollectionDataModelStruct(
      historyCallStatus: historyCallStatus,
      historyCallTime: historyCallTime,
      historyLeadStatus: historyLeadStatus,
      historyReasonName: historyReasonName,
      ardate: ardate,
      arappdate: arappdate,
      remgcode: remgcode,
      remdetcode: remdetcode,
      ardesc: ardesc,
      channel: channel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HistoryCollectionDataModelStruct? updateHistoryCollectionDataModelStruct(
  HistoryCollectionDataModelStruct? historyCollectionDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    historyCollectionDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHistoryCollectionDataModelStructData(
  Map<String, dynamic> firestoreData,
  HistoryCollectionDataModelStruct? historyCollectionDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (historyCollectionDataModel == null) {
    return;
  }
  if (historyCollectionDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      historyCollectionDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final historyCollectionDataModelData =
      getHistoryCollectionDataModelFirestoreData(
          historyCollectionDataModel, forFieldValue);
  final nestedData = historyCollectionDataModelData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      historyCollectionDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHistoryCollectionDataModelFirestoreData(
  HistoryCollectionDataModelStruct? historyCollectionDataModel, [
  bool forFieldValue = false,
]) {
  if (historyCollectionDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(historyCollectionDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(historyCollectionDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHistoryCollectionDataModelListFirestoreData(
  List<HistoryCollectionDataModelStruct>? historyCollectionDataModels,
) =>
    historyCollectionDataModels
        ?.map((e) => getHistoryCollectionDataModelFirestoreData(e, true))
        .toList() ??
    [];
