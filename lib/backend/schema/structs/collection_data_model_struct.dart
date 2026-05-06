// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CollectionDataModelStruct extends FFFirebaseStruct {
  CollectionDataModelStruct({
    String? id,
    String? database,
    String? dbname,
    String? comcode,
    String? name1,
    String? name2,
    String? contno,
    String? mobileNumber,
    String? cuscod,
    String? teamFromCld,
    String? expDay,
    String? dayofdue,
    String? ardate,
    String? codebranch,
    String? codenamebranch,
    String? namebranch,
    String? codekate,
    String? coderegion,
    String? codenameregion,
    String? callType,
    String? expAmt,
    String? targetstat,
    String? contstat,
    String? fdate,
    String? arnow,
    String? statusREFCONTNO,
    String? dateofdata,
    String? sumCurrentdueamt,
    String? nextWork,
    String? ppdate,
    String? expFrm,
    String? dateofexp,
    String? dateofdue,
    String? lpayd,
    String? dataTab,
    String? historyCount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _database = database,
        _dbname = dbname,
        _comcode = comcode,
        _name1 = name1,
        _name2 = name2,
        _contno = contno,
        _mobileNumber = mobileNumber,
        _cuscod = cuscod,
        _teamFromCld = teamFromCld,
        _expDay = expDay,
        _dayofdue = dayofdue,
        _ardate = ardate,
        _codebranch = codebranch,
        _codenamebranch = codenamebranch,
        _namebranch = namebranch,
        _codekate = codekate,
        _coderegion = coderegion,
        _codenameregion = codenameregion,
        _callType = callType,
        _expAmt = expAmt,
        _targetstat = targetstat,
        _contstat = contstat,
        _fdate = fdate,
        _arnow = arnow,
        _statusREFCONTNO = statusREFCONTNO,
        _dateofdata = dateofdata,
        _sumCurrentdueamt = sumCurrentdueamt,
        _nextWork = nextWork,
        _ppdate = ppdate,
        _expFrm = expFrm,
        _dateofexp = dateofexp,
        _dateofdue = dateofdue,
        _lpayd = lpayd,
        _dataTab = dataTab,
        _historyCount = historyCount,
        super(firestoreUtilData);

  // "ID" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "DATABASE" field.
  String? _database;
  String get database => _database ?? '';
  set database(String? val) => _database = val;

  bool hasDatabase() => _database != null;

  // "DBNAME" field.
  String? _dbname;
  String get dbname => _dbname ?? '';
  set dbname(String? val) => _dbname = val;

  bool hasDbname() => _dbname != null;

  // "COMCODE" field.
  String? _comcode;
  String get comcode => _comcode ?? '';
  set comcode(String? val) => _comcode = val;

  bool hasComcode() => _comcode != null;

  // "NAME1" field.
  String? _name1;
  String get name1 => _name1 ?? '';
  set name1(String? val) => _name1 = val;

  bool hasName1() => _name1 != null;

  // "NAME2" field.
  String? _name2;
  String get name2 => _name2 ?? '';
  set name2(String? val) => _name2 = val;

  bool hasName2() => _name2 != null;

  // "CONTNO" field.
  String? _contno;
  String get contno => _contno ?? '';
  set contno(String? val) => _contno = val;

  bool hasContno() => _contno != null;

  // "MOBILE_NUMBER" field.
  String? _mobileNumber;
  String get mobileNumber => _mobileNumber ?? '';
  set mobileNumber(String? val) => _mobileNumber = val;

  bool hasMobileNumber() => _mobileNumber != null;

  // "CUSCOD" field.
  String? _cuscod;
  String get cuscod => _cuscod ?? '';
  set cuscod(String? val) => _cuscod = val;

  bool hasCuscod() => _cuscod != null;

  // "TEAM_FROM_CLD" field.
  String? _teamFromCld;
  String get teamFromCld => _teamFromCld ?? '';
  set teamFromCld(String? val) => _teamFromCld = val;

  bool hasTeamFromCld() => _teamFromCld != null;

  // "EXP_DAY" field.
  String? _expDay;
  String get expDay => _expDay ?? '';
  set expDay(String? val) => _expDay = val;

  bool hasExpDay() => _expDay != null;

  // "DAYOFDUE" field.
  String? _dayofdue;
  String get dayofdue => _dayofdue ?? '';
  set dayofdue(String? val) => _dayofdue = val;

  bool hasDayofdue() => _dayofdue != null;

  // "ARDATE" field.
  String? _ardate;
  String get ardate => _ardate ?? '';
  set ardate(String? val) => _ardate = val;

  bool hasArdate() => _ardate != null;

  // "CODEBRANCH" field.
  String? _codebranch;
  String get codebranch => _codebranch ?? '';
  set codebranch(String? val) => _codebranch = val;

  bool hasCodebranch() => _codebranch != null;

  // "CODENAMEBRANCH" field.
  String? _codenamebranch;
  String get codenamebranch => _codenamebranch ?? '';
  set codenamebranch(String? val) => _codenamebranch = val;

  bool hasCodenamebranch() => _codenamebranch != null;

  // "NAMEBRANCH" field.
  String? _namebranch;
  String get namebranch => _namebranch ?? '';
  set namebranch(String? val) => _namebranch = val;

  bool hasNamebranch() => _namebranch != null;

  // "CODEKATE" field.
  String? _codekate;
  String get codekate => _codekate ?? '';
  set codekate(String? val) => _codekate = val;

  bool hasCodekate() => _codekate != null;

  // "CODEREGION" field.
  String? _coderegion;
  String get coderegion => _coderegion ?? '';
  set coderegion(String? val) => _coderegion = val;

  bool hasCoderegion() => _coderegion != null;

  // "CODENAMEREGION" field.
  String? _codenameregion;
  String get codenameregion => _codenameregion ?? '';
  set codenameregion(String? val) => _codenameregion = val;

  bool hasCodenameregion() => _codenameregion != null;

  // "CALL_TYPE" field.
  String? _callType;
  String get callType => _callType ?? '';
  set callType(String? val) => _callType = val;

  bool hasCallType() => _callType != null;

  // "EXP_AMT" field.
  String? _expAmt;
  String get expAmt => _expAmt ?? '';
  set expAmt(String? val) => _expAmt = val;

  bool hasExpAmt() => _expAmt != null;

  // "TARGETSTAT" field.
  String? _targetstat;
  String get targetstat => _targetstat ?? '';
  set targetstat(String? val) => _targetstat = val;

  bool hasTargetstat() => _targetstat != null;

  // "CONTSTAT" field.
  String? _contstat;
  String get contstat => _contstat ?? '';
  set contstat(String? val) => _contstat = val;

  bool hasContstat() => _contstat != null;

  // "FDATE" field.
  String? _fdate;
  String get fdate => _fdate ?? '';
  set fdate(String? val) => _fdate = val;

  bool hasFdate() => _fdate != null;

  // "ARNOW" field.
  String? _arnow;
  String get arnow => _arnow ?? '';
  set arnow(String? val) => _arnow = val;

  bool hasArnow() => _arnow != null;

  // "Status_REFCONTNO" field.
  String? _statusREFCONTNO;
  String get statusREFCONTNO => _statusREFCONTNO ?? '';
  set statusREFCONTNO(String? val) => _statusREFCONTNO = val;

  bool hasStatusREFCONTNO() => _statusREFCONTNO != null;

  // "DATEOFDATA" field.
  String? _dateofdata;
  String get dateofdata => _dateofdata ?? '';
  set dateofdata(String? val) => _dateofdata = val;

  bool hasDateofdata() => _dateofdata != null;

  // "SUM_CURRENTDUEAMT" field.
  String? _sumCurrentdueamt;
  String get sumCurrentdueamt => _sumCurrentdueamt ?? '';
  set sumCurrentdueamt(String? val) => _sumCurrentdueamt = val;

  bool hasSumCurrentdueamt() => _sumCurrentdueamt != null;

  // "NextWork" field.
  String? _nextWork;
  String get nextWork => _nextWork ?? '';
  set nextWork(String? val) => _nextWork = val;

  bool hasNextWork() => _nextWork != null;

  // "PPDATE" field.
  String? _ppdate;
  String get ppdate => _ppdate ?? '';
  set ppdate(String? val) => _ppdate = val;

  bool hasPpdate() => _ppdate != null;

  // "EXP_FRM" field.
  String? _expFrm;
  String get expFrm => _expFrm ?? '';
  set expFrm(String? val) => _expFrm = val;

  bool hasExpFrm() => _expFrm != null;

  // "DATEOFEXP" field.
  String? _dateofexp;
  String get dateofexp => _dateofexp ?? '';
  set dateofexp(String? val) => _dateofexp = val;

  bool hasDateofexp() => _dateofexp != null;

  // "DATEOFDUE" field.
  String? _dateofdue;
  String get dateofdue => _dateofdue ?? '';
  set dateofdue(String? val) => _dateofdue = val;

  bool hasDateofdue() => _dateofdue != null;

  // "LPAYD" field.
  String? _lpayd;
  String get lpayd => _lpayd ?? '';
  set lpayd(String? val) => _lpayd = val;

  bool hasLpayd() => _lpayd != null;

  // "dataTab" field.
  String? _dataTab;
  String get dataTab => _dataTab ?? '';
  set dataTab(String? val) => _dataTab = val;

  bool hasDataTab() => _dataTab != null;

  // "historyCount" field.
  String? _historyCount;
  String get historyCount => _historyCount ?? '';
  set historyCount(String? val) => _historyCount = val;

  bool hasHistoryCount() => _historyCount != null;

  static CollectionDataModelStruct fromMap(Map<String, dynamic> data) =>
      CollectionDataModelStruct(
        id: data['ID'] as String?,
        database: data['DATABASE'] as String?,
        dbname: data['DBNAME'] as String?,
        comcode: data['COMCODE'] as String?,
        name1: data['NAME1'] as String?,
        name2: data['NAME2'] as String?,
        contno: data['CONTNO'] as String?,
        mobileNumber: data['MOBILE_NUMBER'] as String?,
        cuscod: data['CUSCOD'] as String?,
        teamFromCld: data['TEAM_FROM_CLD'] as String?,
        expDay: data['EXP_DAY'] as String?,
        dayofdue: data['DAYOFDUE'] as String?,
        ardate: data['ARDATE'] as String?,
        codebranch: data['CODEBRANCH'] as String?,
        codenamebranch: data['CODENAMEBRANCH'] as String?,
        namebranch: data['NAMEBRANCH'] as String?,
        codekate: data['CODEKATE'] as String?,
        coderegion: data['CODEREGION'] as String?,
        codenameregion: data['CODENAMEREGION'] as String?,
        callType: data['CALL_TYPE'] as String?,
        expAmt: data['EXP_AMT'] as String?,
        targetstat: data['TARGETSTAT'] as String?,
        contstat: data['CONTSTAT'] as String?,
        fdate: data['FDATE'] as String?,
        arnow: data['ARNOW'] as String?,
        statusREFCONTNO: data['Status_REFCONTNO'] as String?,
        dateofdata: data['DATEOFDATA'] as String?,
        sumCurrentdueamt: data['SUM_CURRENTDUEAMT'] as String?,
        nextWork: data['NextWork'] as String?,
        ppdate: data['PPDATE'] as String?,
        expFrm: data['EXP_FRM'] as String?,
        dateofexp: data['DATEOFEXP'] as String?,
        dateofdue: data['DATEOFDUE'] as String?,
        lpayd: data['LPAYD'] as String?,
        dataTab: data['dataTab'] as String?,
        historyCount: data['historyCount'] as String?,
      );

  static CollectionDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? CollectionDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ID': _id,
        'DATABASE': _database,
        'DBNAME': _dbname,
        'COMCODE': _comcode,
        'NAME1': _name1,
        'NAME2': _name2,
        'CONTNO': _contno,
        'MOBILE_NUMBER': _mobileNumber,
        'CUSCOD': _cuscod,
        'TEAM_FROM_CLD': _teamFromCld,
        'EXP_DAY': _expDay,
        'DAYOFDUE': _dayofdue,
        'ARDATE': _ardate,
        'CODEBRANCH': _codebranch,
        'CODENAMEBRANCH': _codenamebranch,
        'NAMEBRANCH': _namebranch,
        'CODEKATE': _codekate,
        'CODEREGION': _coderegion,
        'CODENAMEREGION': _codenameregion,
        'CALL_TYPE': _callType,
        'EXP_AMT': _expAmt,
        'TARGETSTAT': _targetstat,
        'CONTSTAT': _contstat,
        'FDATE': _fdate,
        'ARNOW': _arnow,
        'Status_REFCONTNO': _statusREFCONTNO,
        'DATEOFDATA': _dateofdata,
        'SUM_CURRENTDUEAMT': _sumCurrentdueamt,
        'NextWork': _nextWork,
        'PPDATE': _ppdate,
        'EXP_FRM': _expFrm,
        'DATEOFEXP': _dateofexp,
        'DATEOFDUE': _dateofdue,
        'LPAYD': _lpayd,
        'dataTab': _dataTab,
        'historyCount': _historyCount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ID': serializeParam(
          _id,
          ParamType.String,
        ),
        'DATABASE': serializeParam(
          _database,
          ParamType.String,
        ),
        'DBNAME': serializeParam(
          _dbname,
          ParamType.String,
        ),
        'COMCODE': serializeParam(
          _comcode,
          ParamType.String,
        ),
        'NAME1': serializeParam(
          _name1,
          ParamType.String,
        ),
        'NAME2': serializeParam(
          _name2,
          ParamType.String,
        ),
        'CONTNO': serializeParam(
          _contno,
          ParamType.String,
        ),
        'MOBILE_NUMBER': serializeParam(
          _mobileNumber,
          ParamType.String,
        ),
        'CUSCOD': serializeParam(
          _cuscod,
          ParamType.String,
        ),
        'TEAM_FROM_CLD': serializeParam(
          _teamFromCld,
          ParamType.String,
        ),
        'EXP_DAY': serializeParam(
          _expDay,
          ParamType.String,
        ),
        'DAYOFDUE': serializeParam(
          _dayofdue,
          ParamType.String,
        ),
        'ARDATE': serializeParam(
          _ardate,
          ParamType.String,
        ),
        'CODEBRANCH': serializeParam(
          _codebranch,
          ParamType.String,
        ),
        'CODENAMEBRANCH': serializeParam(
          _codenamebranch,
          ParamType.String,
        ),
        'NAMEBRANCH': serializeParam(
          _namebranch,
          ParamType.String,
        ),
        'CODEKATE': serializeParam(
          _codekate,
          ParamType.String,
        ),
        'CODEREGION': serializeParam(
          _coderegion,
          ParamType.String,
        ),
        'CODENAMEREGION': serializeParam(
          _codenameregion,
          ParamType.String,
        ),
        'CALL_TYPE': serializeParam(
          _callType,
          ParamType.String,
        ),
        'EXP_AMT': serializeParam(
          _expAmt,
          ParamType.String,
        ),
        'TARGETSTAT': serializeParam(
          _targetstat,
          ParamType.String,
        ),
        'CONTSTAT': serializeParam(
          _contstat,
          ParamType.String,
        ),
        'FDATE': serializeParam(
          _fdate,
          ParamType.String,
        ),
        'ARNOW': serializeParam(
          _arnow,
          ParamType.String,
        ),
        'Status_REFCONTNO': serializeParam(
          _statusREFCONTNO,
          ParamType.String,
        ),
        'DATEOFDATA': serializeParam(
          _dateofdata,
          ParamType.String,
        ),
        'SUM_CURRENTDUEAMT': serializeParam(
          _sumCurrentdueamt,
          ParamType.String,
        ),
        'NextWork': serializeParam(
          _nextWork,
          ParamType.String,
        ),
        'PPDATE': serializeParam(
          _ppdate,
          ParamType.String,
        ),
        'EXP_FRM': serializeParam(
          _expFrm,
          ParamType.String,
        ),
        'DATEOFEXP': serializeParam(
          _dateofexp,
          ParamType.String,
        ),
        'DATEOFDUE': serializeParam(
          _dateofdue,
          ParamType.String,
        ),
        'LPAYD': serializeParam(
          _lpayd,
          ParamType.String,
        ),
        'dataTab': serializeParam(
          _dataTab,
          ParamType.String,
        ),
        'historyCount': serializeParam(
          _historyCount,
          ParamType.String,
        ),
      }.withoutNulls;

  static CollectionDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CollectionDataModelStruct(
        id: deserializeParam(
          data['ID'],
          ParamType.String,
          false,
        ),
        database: deserializeParam(
          data['DATABASE'],
          ParamType.String,
          false,
        ),
        dbname: deserializeParam(
          data['DBNAME'],
          ParamType.String,
          false,
        ),
        comcode: deserializeParam(
          data['COMCODE'],
          ParamType.String,
          false,
        ),
        name1: deserializeParam(
          data['NAME1'],
          ParamType.String,
          false,
        ),
        name2: deserializeParam(
          data['NAME2'],
          ParamType.String,
          false,
        ),
        contno: deserializeParam(
          data['CONTNO'],
          ParamType.String,
          false,
        ),
        mobileNumber: deserializeParam(
          data['MOBILE_NUMBER'],
          ParamType.String,
          false,
        ),
        cuscod: deserializeParam(
          data['CUSCOD'],
          ParamType.String,
          false,
        ),
        teamFromCld: deserializeParam(
          data['TEAM_FROM_CLD'],
          ParamType.String,
          false,
        ),
        expDay: deserializeParam(
          data['EXP_DAY'],
          ParamType.String,
          false,
        ),
        dayofdue: deserializeParam(
          data['DAYOFDUE'],
          ParamType.String,
          false,
        ),
        ardate: deserializeParam(
          data['ARDATE'],
          ParamType.String,
          false,
        ),
        codebranch: deserializeParam(
          data['CODEBRANCH'],
          ParamType.String,
          false,
        ),
        codenamebranch: deserializeParam(
          data['CODENAMEBRANCH'],
          ParamType.String,
          false,
        ),
        namebranch: deserializeParam(
          data['NAMEBRANCH'],
          ParamType.String,
          false,
        ),
        codekate: deserializeParam(
          data['CODEKATE'],
          ParamType.String,
          false,
        ),
        coderegion: deserializeParam(
          data['CODEREGION'],
          ParamType.String,
          false,
        ),
        codenameregion: deserializeParam(
          data['CODENAMEREGION'],
          ParamType.String,
          false,
        ),
        callType: deserializeParam(
          data['CALL_TYPE'],
          ParamType.String,
          false,
        ),
        expAmt: deserializeParam(
          data['EXP_AMT'],
          ParamType.String,
          false,
        ),
        targetstat: deserializeParam(
          data['TARGETSTAT'],
          ParamType.String,
          false,
        ),
        contstat: deserializeParam(
          data['CONTSTAT'],
          ParamType.String,
          false,
        ),
        fdate: deserializeParam(
          data['FDATE'],
          ParamType.String,
          false,
        ),
        arnow: deserializeParam(
          data['ARNOW'],
          ParamType.String,
          false,
        ),
        statusREFCONTNO: deserializeParam(
          data['Status_REFCONTNO'],
          ParamType.String,
          false,
        ),
        dateofdata: deserializeParam(
          data['DATEOFDATA'],
          ParamType.String,
          false,
        ),
        sumCurrentdueamt: deserializeParam(
          data['SUM_CURRENTDUEAMT'],
          ParamType.String,
          false,
        ),
        nextWork: deserializeParam(
          data['NextWork'],
          ParamType.String,
          false,
        ),
        ppdate: deserializeParam(
          data['PPDATE'],
          ParamType.String,
          false,
        ),
        expFrm: deserializeParam(
          data['EXP_FRM'],
          ParamType.String,
          false,
        ),
        dateofexp: deserializeParam(
          data['DATEOFEXP'],
          ParamType.String,
          false,
        ),
        dateofdue: deserializeParam(
          data['DATEOFDUE'],
          ParamType.String,
          false,
        ),
        lpayd: deserializeParam(
          data['LPAYD'],
          ParamType.String,
          false,
        ),
        dataTab: deserializeParam(
          data['dataTab'],
          ParamType.String,
          false,
        ),
        historyCount: deserializeParam(
          data['historyCount'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CollectionDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CollectionDataModelStruct &&
        id == other.id &&
        database == other.database &&
        dbname == other.dbname &&
        comcode == other.comcode &&
        name1 == other.name1 &&
        name2 == other.name2 &&
        contno == other.contno &&
        mobileNumber == other.mobileNumber &&
        cuscod == other.cuscod &&
        teamFromCld == other.teamFromCld &&
        expDay == other.expDay &&
        dayofdue == other.dayofdue &&
        ardate == other.ardate &&
        codebranch == other.codebranch &&
        codenamebranch == other.codenamebranch &&
        namebranch == other.namebranch &&
        codekate == other.codekate &&
        coderegion == other.coderegion &&
        codenameregion == other.codenameregion &&
        callType == other.callType &&
        expAmt == other.expAmt &&
        targetstat == other.targetstat &&
        contstat == other.contstat &&
        fdate == other.fdate &&
        arnow == other.arnow &&
        statusREFCONTNO == other.statusREFCONTNO &&
        dateofdata == other.dateofdata &&
        sumCurrentdueamt == other.sumCurrentdueamt &&
        nextWork == other.nextWork &&
        ppdate == other.ppdate &&
        expFrm == other.expFrm &&
        dateofexp == other.dateofexp &&
        dateofdue == other.dateofdue &&
        lpayd == other.lpayd &&
        dataTab == other.dataTab &&
        historyCount == other.historyCount;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        database,
        dbname,
        comcode,
        name1,
        name2,
        contno,
        mobileNumber,
        cuscod,
        teamFromCld,
        expDay,
        dayofdue,
        ardate,
        codebranch,
        codenamebranch,
        namebranch,
        codekate,
        coderegion,
        codenameregion,
        callType,
        expAmt,
        targetstat,
        contstat,
        fdate,
        arnow,
        statusREFCONTNO,
        dateofdata,
        sumCurrentdueamt,
        nextWork,
        ppdate,
        expFrm,
        dateofexp,
        dateofdue,
        lpayd,
        dataTab,
        historyCount
      ]);
}

CollectionDataModelStruct createCollectionDataModelStruct({
  String? id,
  String? database,
  String? dbname,
  String? comcode,
  String? name1,
  String? name2,
  String? contno,
  String? mobileNumber,
  String? cuscod,
  String? teamFromCld,
  String? expDay,
  String? dayofdue,
  String? ardate,
  String? codebranch,
  String? codenamebranch,
  String? namebranch,
  String? codekate,
  String? coderegion,
  String? codenameregion,
  String? callType,
  String? expAmt,
  String? targetstat,
  String? contstat,
  String? fdate,
  String? arnow,
  String? statusREFCONTNO,
  String? dateofdata,
  String? sumCurrentdueamt,
  String? nextWork,
  String? ppdate,
  String? expFrm,
  String? dateofexp,
  String? dateofdue,
  String? lpayd,
  String? dataTab,
  String? historyCount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CollectionDataModelStruct(
      id: id,
      database: database,
      dbname: dbname,
      comcode: comcode,
      name1: name1,
      name2: name2,
      contno: contno,
      mobileNumber: mobileNumber,
      cuscod: cuscod,
      teamFromCld: teamFromCld,
      expDay: expDay,
      dayofdue: dayofdue,
      ardate: ardate,
      codebranch: codebranch,
      codenamebranch: codenamebranch,
      namebranch: namebranch,
      codekate: codekate,
      coderegion: coderegion,
      codenameregion: codenameregion,
      callType: callType,
      expAmt: expAmt,
      targetstat: targetstat,
      contstat: contstat,
      fdate: fdate,
      arnow: arnow,
      statusREFCONTNO: statusREFCONTNO,
      dateofdata: dateofdata,
      sumCurrentdueamt: sumCurrentdueamt,
      nextWork: nextWork,
      ppdate: ppdate,
      expFrm: expFrm,
      dateofexp: dateofexp,
      dateofdue: dateofdue,
      lpayd: lpayd,
      dataTab: dataTab,
      historyCount: historyCount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CollectionDataModelStruct? updateCollectionDataModelStruct(
  CollectionDataModelStruct? collectionDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    collectionDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCollectionDataModelStructData(
  Map<String, dynamic> firestoreData,
  CollectionDataModelStruct? collectionDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (collectionDataModel == null) {
    return;
  }
  if (collectionDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && collectionDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final collectionDataModelData =
      getCollectionDataModelFirestoreData(collectionDataModel, forFieldValue);
  final nestedData =
      collectionDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      collectionDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCollectionDataModelFirestoreData(
  CollectionDataModelStruct? collectionDataModel, [
  bool forFieldValue = false,
]) {
  if (collectionDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(collectionDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(collectionDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCollectionDataModelListFirestoreData(
  List<CollectionDataModelStruct>? collectionDataModels,
) =>
    collectionDataModels
        ?.map((e) => getCollectionDataModelFirestoreData(e, true))
        .toList() ??
    [];
