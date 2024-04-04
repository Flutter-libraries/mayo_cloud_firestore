import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Convert timestamp --> date
class TimestampMapConverter
    implements JsonConverter<DateTime?, Map<String, dynamic>?> {
  /// Factory constructor
  factory TimestampMapConverter({String? secondsKey, String? nanosecondsKey}) {
    return TimestampMapConverter._(
      secondsKey: secondsKey,
      nanosecondsKey: nanosecondsKey,
    );
  }

  /// Constructor
  TimestampMapConverter._({
    this.secondsKey,
    this.nanosecondsKey,
  });

  /// Key for seconds
  final String? secondsKey;

  /// Key for nanoseconds
  final String? nanosecondsKey;

  @override
  DateTime? fromJson(Map<String, dynamic>? timestamp) {
    if (timestamp == null ||
        timestamp[secondsKey ?? '_seconds'] == null ||
        timestamp[nanosecondsKey ?? '_nanoseconds'] == null ||
        timestamp[secondsKey ?? '_seconds'] is! int ||
        timestamp[nanosecondsKey ?? '_nanoseconds'] is! int) {
      return null;
    }
    return Timestamp(
      timestamp[secondsKey ?? '_seconds'] as int,
      timestamp[nanosecondsKey ?? '_nanoseconds'] as int,
    ).toDate();
  }

  @override
  Map<String, dynamic>? toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    final ts = Timestamp.fromDate(date);

    return {
      secondsKey ?? '_seconds': ts.seconds,
      nanosecondsKey ?? '_nanoseconds': ts.nanoseconds,
    };
  }
}
