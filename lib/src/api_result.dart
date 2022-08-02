/// Wrapper class to freezed class
abstract class ApiResult<T> {
  /// Return freezed class from response
  static T fromResponse<T>(
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return fromJson(data);
  }
}
