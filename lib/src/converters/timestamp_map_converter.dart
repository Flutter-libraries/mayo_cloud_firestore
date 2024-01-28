import 'package:freezed_annotation/freezed_annotation.dart';

///
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
    return DateTime.fromMillisecondsSinceEpoch(
      (timestamp['_seconds'] as int) * 1000 +
          (timestamp['_nanoseconds'] as int) ~/ 1000,
    );
  }

  @override
  Map<String, dynamic>? toJson(DateTime? date) {
    if (date == null) {
      return null;
    }
    return {
      '_seconds': date.millisecondsSinceEpoch ~/ 1000,
      '_nanoseconds': (date.millisecondsSinceEpoch % 1000) * 1000,
    };
  }
}
