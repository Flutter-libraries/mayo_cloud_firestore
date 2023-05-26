import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FirebaseReference {
  FirebaseReference(this.id, this.path);

  final String id;
  final String path;
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
  DocumentReference? toJson(FirebaseReference? path) =>
      path != null ? FirebaseFirestore.instance.doc(path.path) : null;
}
