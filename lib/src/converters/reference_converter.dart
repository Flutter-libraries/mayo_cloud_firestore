import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mayo_cloud_firestore/src/api_result.dart';

/// Firebase reference
class FirebaseReference {
  /// Constructor
  FirebaseReference(this.id, this.path);

  final String id;
  final String path;

  DocumentReference? toDocumentReference() =>
      FirebaseFirestore.instance.doc('${path}/${id}');
}

/// Convert ref --> string
class ReferenceConverter
    implements JsonConverter<FirebaseReference?, DocumentReference?> {
  /// Constructor
  const ReferenceConverter();

  @override
  FirebaseReference? fromJson(DocumentReference? reference) {
    return reference != null
        ? FirebaseReference(reference.id, reference.path)
        : null;
  }

  @override
  DocumentReference? toJson(FirebaseReference? reference) => reference != null
      ? FirebaseFirestore.instance.doc('${reference.path}/${reference.id}')
      : null;
}

///
extension GetData<T> on FirebaseReference {
  ///
  Future<T> get<T>(
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final results = await FirebaseFirestore.instance.doc(path).get();

    return ApiResult.fromResponse(
        ApiResult.toMap(results.data(), id), fromJson);
  }
}

class ReferencesConverter
    implements JsonConverter<List<FirebaseReference>?, List<dynamic>?> {
  /// Constructor
  const ReferencesConverter();

  @override
  List<FirebaseReference>? fromJson(List<dynamic>? references) => references
      ?.map((e) => FirebaseReference((e as DocumentReference).id, e.path))
      .toList();

  @override
  List<DocumentReference>? toJson(
          List<FirebaseReference>? references) =>
      references
          ?.map((e) => FirebaseFirestore.instance.doc('${e.path}/${e.id}')
              as DocumentReference)
          .toList();
}
