class ErrorModel {
  final String errorMessage;

  ErrorModel({
    required this.errorMessage,
  });

  factory ErrorModel.fromJson(Map jsonData) {
     
    if (jsonData['errors'] is List && jsonData['errors'].isNotEmpty) {
      return ErrorModel(
        errorMessage: jsonData['errors'][0]['msg'] ?? 'Unknown error occurred',
      );
    }
    return ErrorModel(
      errorMessage: jsonData['msg'] ?? 'Unknown error occurred',
    );
  }
}
