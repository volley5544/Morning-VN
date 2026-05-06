// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SaveCallCollectionDataModelStruct extends FFFirebaseStruct {
  SaveCallCollectionDataModelStruct({
    String? contnoId,
    String? contno,
    String? server,
    String? historyLeadStatus,
    String? historyReasonName,
    String? createdUserid,
    String? updatedUserid,
    String? arappdate,
    String? ardesc,
    String? userid,
    String? remgcode,
    String? remdetcode,
    String? amount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _contnoId = contnoId,
        _contno = contno,
        _server = server,
        _historyLeadStatus = historyLeadStatus,
        _historyReasonName = historyReasonName,
        _createdUserid = createdUserid,
        _updatedUserid = updatedUserid,
        _arappdate = arappdate,
        _ardesc = ardesc,
        _userid = userid,
        _remgcode = remgcode,
        _remdetcode = remdetcode,
        _amount = amount,
        super(firestoreUtilData);

  // "CONTNO_ID" field.
  String? _contnoId;
  String get contnoId => _contnoId ?? '';
  set contnoId(String? val) => _contnoId = val;

  bool hasContnoId() => _contnoId != null;

  // "CONTNO" field.
  String? _contno;
  String get contno => _contno ?? '';
  set contno(String? val) => _contno = val;

  bool hasContno() => _contno != null;

  // "SERVER" field.
  String? _server;
  String get server => _server ?? '';
  set server(String? val) => _server = val;

  bool hasServer() => _server != null;

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

  // "CREATED_USERID" field.
  String? _createdUserid;
  String get createdUserid => _createdUserid ?? '';
  set createdUserid(String? val) => _createdUserid = val;

  bool hasCreatedUserid() => _createdUserid != null;

  // "UPDATED_USERID" field.
  String? _updatedUserid;
  String get updatedUserid => _updatedUserid ?? '';
  set updatedUserid(String? val) => _updatedUserid = val;

  bool hasUpdatedUserid() => _updatedUserid != null;

  // "ARAPPDATE" field.
  String? _arappdate;
  String get arappdate => _arappdate ?? '';
  set arappdate(String? val) => _arappdate = val;

  bool hasArappdate() => _arappdate != null;

  // "ARDESC" field.
  String? _ardesc;
  String get ardesc => _ardesc ?? '';
  set ardesc(String? val) => _ardesc = val;

  bool hasArdesc() => _ardesc != null;

  // "USERID" field.
  String? _userid;
  String get userid => _userid ?? '';
  set userid(String? val) => _userid = val;

  bool hasUserid() => _userid != null;

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

  // "AMOUNT" field.
  String? _amount;
  String get amount => _amount ?? '';
  set amount(String? val) => _amount = val;

  bool hasAmount() => _amount != null;

  static SaveCallCollectionDataModelStruct fromMap(Map<String, dynamic> data) =>
      SaveCallCollectionDataModelStruct(
        contnoId: data['CONTNO_ID'] as String?,
        contno: data['CONTNO'] as String?,
        server: data['SERVER'] as String?,
        historyLeadStatus: data['HISTORY_LEAD_STATUS'] as String?,
        historyReasonName: data['HISTORY_REASON_NAME'] as String?,
        createdUserid: data['CREATED_USERID'] as String?,
        updatedUserid: data['UPDATED_USERID'] as String?,
        arappdate: data['ARAPPDATE'] as String?,
        ardesc: data['ARDESC'] as String?,
        userid: data['USERID'] as String?,
        remgcode: data['REMGCODE'] as String?,
        remdetcode: data['REMDETCODE'] as String?,
        amount: data['AMOUNT'] as String?,
      );

  static SaveCallCollectionDataModelStruct? maybeFromMap(dynamic data) => data
          is Map
      ? SaveCallCollectionDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'CONTNO_ID': _contnoId,
        'CONTNO': _contno,
        'SERVER': _server,
        'HISTORY_LEAD_STATUS': _historyLeadStatus,
        'HISTORY_REASON_NAME': _historyReasonName,
        'CREATED_USERID': _createdUserid,
        'UPDATED_USERID': _updatedUserid,
        'ARAPPDATE': _arappdate,
        'ARDESC': _ardesc,
        'USERID': _userid,
        'REMGCODE': _remgcode,
        'REMDETCODE': _remdetcode,
        'AMOUNT': _amount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'CONTNO_ID': serializeParam(
          _contnoId,
          ParamType.String,
        ),
        'CONTNO': serializeParam(
          _contno,
          ParamType.String,
        ),
        'SERVER': serializeParam(
          _server,
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
        'CREATED_USERID': serializeParam(
          _createdUserid,
          ParamType.String,
        ),
        'UPDATED_USERID': serializeParam(
          _updatedUserid,
          ParamType.String,
        ),
        'ARAPPDATE': serializeParam(
          _arappdate,
          ParamType.String,
        ),
        'ARDESC': serializeParam(
          _ardesc,
          ParamType.String,
        ),
        'USERID': serializeParam(
          _userid,
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
        'AMOUNT': serializeParam(
          _amount,
          ParamType.String,
        ),
      }.withoutNulls;

  static SaveCallCollectionDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SaveCallCollectionDataModelStruct(
        contnoId: deserializeParam(
          data['CONTNO_ID'],
          ParamType.String,
          false,
        ),
        contno: deserializeParam(
          data['CONTNO'],
          ParamType.String,
          false,
        ),
        server: deserializeParam(
          data['SERVER'],
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
        createdUserid: deserializeParam(
          data['CREATED_USERID'],
          ParamType.String,
          false,
        ),
        updatedUserid: deserializeParam(
          data['UPDATED_USERID'],
          ParamType.String,
          false,
        ),
        arappdate: deserializeParam(
          data['ARAPPDATE'],
          ParamType.String,
          false,
        ),
        ardesc: deserializeParam(
          data['ARDESC'],
          ParamType.String,
          false,
        ),
        userid: deserializeParam(
          data['USERID'],
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
        amount: deserializeParam(
          data['AMOUNT'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SaveCallCollectionDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SaveCallCollectionDataModelStruct &&
        contnoId == other.contnoId &&
        contno == other.contno &&
        server == other.server &&
        historyLeadStatus == other.historyLeadStatus &&
        historyReasonName == other.historyReasonName &&
        createdUserid == other.createdUserid &&
        updatedUserid == other.updatedUserid &&
        arappdate == other.arappdate &&
        ardesc == other.ardesc &&
        userid == other.userid &&
        remgcode == other.remgcode &&
        remdetcode == other.remdetcode &&
        amount == other.amount;
  }

  @override
  int get hashCode => const ListEquality().hash([
        contnoId,
        contno,
        server,
        historyLeadStatus,
        historyReasonName,
        createdUserid,
        updatedUserid,
        arappdate,
        ardesc,
        userid,
        remgcode,
        remdetcode,
        amount
      ]);
}

SaveCallCollectionDataModelStruct createSaveCallCollectionDataModelStruct({
  String? contnoId,
  String? contno,
  String? server,
  String? historyLeadStatus,
  String? historyReasonName,
  String? createdUserid,
  String? updatedUserid,
  String? arappdate,
  String? ardesc,
  String? userid,
  String? remgcode,
  String? remdetcode,
  String? amount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SaveCallCollectionDataModelStruct(
      contnoId: contnoId,
      contno: contno,
      server: server,
      historyLeadStatus: historyLeadStatus,
      historyReasonName: historyReasonName,
      createdUserid: createdUserid,
      updatedUserid: updatedUserid,
      arappdate: arappdate,
      ardesc: ardesc,
      userid: userid,
      remgcode: remgcode,
      remdetcode: remdetcode,
      amount: amount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SaveCallCollectionDataModelStruct? updateSaveCallCollectionDataModelStruct(
  SaveCallCollectionDataModelStruct? saveCallCollectionDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    saveCallCollectionDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSaveCallCollectionDataModelStructData(
  Map<String, dynamic> firestoreData,
  SaveCallCollectionDataModelStruct? saveCallCollectionDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (saveCallCollectionDataModel == null) {
    return;
  }
  if (saveCallCollectionDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      saveCallCollectionDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final saveCallCollectionDataModelData =
      getSaveCallCollectionDataModelFirestoreData(
          saveCallCollectionDataModel, forFieldValue);
  final nestedData = saveCallCollectionDataModelData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      saveCallCollectionDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSaveCallCollectionDataModelFirestoreData(
  SaveCallCollectionDataModelStruct? saveCallCollectionDataModel, [
  bool forFieldValue = false,
]) {
  if (saveCallCollectionDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(saveCallCollectionDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(saveCallCollectionDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSaveCallCollectionDataModelListFirestoreData(
  List<SaveCallCollectionDataModelStruct>? saveCallCollectionDataModels,
) =>
    saveCallCollectionDataModels
        ?.map((e) => getSaveCallCollectionDataModelFirestoreData(e, true))
        .toList() ??
    [];
