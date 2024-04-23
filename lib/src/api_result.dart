/// Wrapper class to freezed class
abstract class ApiResult<T> {
  /// Return freezed class from response
  static T fromResponse<T>(
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return fromJson(data);
  }

  /// Convert freezed class to map
  static Map<String, dynamic> toMap(Map<String, dynamic>? data, String id) =>
      {...data ?? {}, 'id': id, 'uid': id};
}
