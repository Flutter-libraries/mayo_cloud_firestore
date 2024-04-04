import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Convert timestamp --> date
class TimestampMapConverter
    implements JsonConverter<DateTime?, Map<String, dynamic>?> {
  ///  constructor
  const TimestampMapConverter()
      : secondsKey = '_seconds',
        nanosecondsKey = '_nanoseconds';

  const TimestampMapConverter.noUnderscored()
      : secondsKey = 'seconds',
        nanosecondsKey = 'nanos';

  /// Key for seconds
  final String secondsKey;

  /// Key for nanoseconds
  final String nanosecondsKey;

  @override
  DateTime? fromJson(Map<String, dynamic>? timestamp) {
    if (timestamp == null ||
        timestamp[secondsKey] == null ||
        timestamp[nanosecondsKey] == null ||
        timestamp[secondsKey] is! int ||
        timestamp[nanosecondsKey] is! int) {
      return null;
    }
    return Timestamp(
      timestamp[secondsKey] as int,
      timestamp[nanosecondsKey] as int,
    ).toDate();
  }

  @override
  Map<String, dynamic>? toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    final ts = Timestamp.fromDate(date);

    return {
      secondsKey: ts.seconds,
      nanosecondsKey: ts.nanoseconds,
    };
  }
}
