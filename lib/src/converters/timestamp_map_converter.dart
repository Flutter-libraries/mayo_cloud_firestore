import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Convert timestamp --> date
class TimestampMapConverter
    implements JsonConverter<DateTime?, Map<String, dynamic>?> {
  /// Constructor
  const TimestampMapConverter();

  @override
  DateTime? fromJson(Map<String, dynamic>? timestamp) {
    if (timestamp == null ||
        timestamp['_seconds'] == null ||
        timestamp['_nanoseconds'] == null ||
        timestamp['_seconds'] is! int ||
        timestamp['_nanoseconds'] is! int) {
      return null;
    }
    return Timestamp(
      timestamp['_seconds'] as int,
      timestamp['_nanoseconds'] as int,
    ).toDate();
  }

  @override
  Map<String, dynamic>? toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    final ts = Timestamp.fromDate(date);

    return {
      '_seconds': ts.seconds,
      '_nanoseconds': ts.nanoseconds,
    };
  }
}
