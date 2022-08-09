import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Convert timestamp --> date
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  /// Constructor
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? dateTime) =>
      dateTime != null ? Timestamp.fromDate(dateTime) : null;
}
