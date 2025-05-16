class ErrorAuth{
  late final String message;
  final List<ApiError> errors;

  ErrorAuth({
    required this.message,
    required this.errors,
  });

  factory ErrorAuth.fromJson(Map<String, dynamic> json) {
    return ErrorAuth(
      message: json['message'] as String,
      errors: (json['errors'] as List)
          .map((i) => ApiError.fromJson(i))
          .toList(),
    );
  }
}

class ApiError {
  final String path;
  final String message;

  ApiError({
    required this.path,
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      path: json['path'] as String,
      message: json['message'] as String,
    );
  }
}
