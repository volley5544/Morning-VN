import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ImageLinkStorageRecord extends FirestoreRecord {
  ImageLinkStorageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "banner_image" field.
  List<String>? _bannerImage;
  List<String> get bannerImage => _bannerImage ?? const [];
  bool hasBannerImage() => _bannerImage != null;

  // "card_image" field.
  List<String>? _cardImage;
  List<String> get cardImage => _cardImage ?? const [];
  bool hasCardImage() => _cardImage != null;

  // "blur_hash" field.
  List<String>? _blurHash;
  List<String> get blurHash => _blurHash ?? const [];
  bool hasBlurHash() => _blurHash != null;

  // "link_url" field.
  List<String>? _linkUrl;
  List<String> get linkUrl => _linkUrl ?? const [];
  bool hasLinkUrl() => _linkUrl != null;

  // "order" field.
  List<int>? _order;
  List<int> get order => _order ?? const [];
  bool hasOrder() => _order != null;

  // "isHaveLink" field.
  List<bool>? _isHaveLink;
  List<bool> get isHaveLink => _isHaveLink ?? const [];
  bool hasIsHaveLink() => _isHaveLink != null;

  void _initializeFields() {
    _bannerImage = getDataList(snapshotData['banner_image']);
    _cardImage = getDataList(snapshotData['card_image']);
    _blurHash = getDataList(snapshotData['blur_hash']);
    _linkUrl = getDataList(snapshotData['link_url']);
    _order = getDataList(snapshotData['order']);
    _isHaveLink = getDataList(snapshotData['isHaveLink']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ImageLinkStorage');

  static Stream<ImageLinkStorageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ImageLinkStorageRecord.fromSnapshot(s));

  static Future<ImageLinkStorageRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ImageLinkStorageRecord.fromSnapshot(s));

  static ImageLinkStorageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ImageLinkStorageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ImageLinkStorageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ImageLinkStorageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ImageLinkStorageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ImageLinkStorageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createImageLinkStorageRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class ImageLinkStorageRecordDocumentEquality
    implements Equality<ImageLinkStorageRecord> {
  const ImageLinkStorageRecordDocumentEquality();

  @override
  bool equals(ImageLinkStorageRecord? e1, ImageLinkStorageRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.bannerImage, e2?.bannerImage) &&
        listEquality.equals(e1?.cardImage, e2?.cardImage) &&
        listEquality.equals(e1?.blurHash, e2?.blurHash) &&
        listEquality.equals(e1?.linkUrl, e2?.linkUrl) &&
        listEquality.equals(e1?.order, e2?.order) &&
        listEquality.equals(e1?.isHaveLink, e2?.isHaveLink);
  }

  @override
  int hash(ImageLinkStorageRecord? e) => const ListEquality().hash([
        e?.bannerImage,
        e?.cardImage,
        e?.blurHash,
        e?.linkUrl,
        e?.order,
        e?.isHaveLink
      ]);

  @override
  bool isValidKey(Object? o) => o is ImageLinkStorageRecord;
}
