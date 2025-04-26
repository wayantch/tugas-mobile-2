class FirebaseException implements Exception {
  final String message;
  final String code;

  FirebaseException({required this.message, required this.code});

  @override
  String toString() => 'FirebaseException: $message (code: $code)';
}
// class NetworkException extends Equatable implements Exception {
//   late final String message;
//   late final bool? success;

//   NetworkException.fromDioError(DioException dioException) {
//     success = dioException.response?.data['success'];

//     switch (dioException.type) {
//       case DioExceptionType.cancel:
//         message = 'Request to API server was cancelled';
//         break;

//       case DioExceptionType.connectionTimeout:
//         message = 'Connection timeout with API server';
//         break;

//       case DioExceptionType.receiveTimeout:
//         message = 'Receive timeout in connection with API server';
//         break;

//       case DioExceptionType.sendTimeout:
//         message = 'Send timeout in connection with API server';
//         break;

//       case DioExceptionType.connectionError:
//         if (dioException.error.runtimeType == SocketException) {
//           message = 'Please check your internet connection';
//           break;
//         } else {
//           message = 'Unexpected error occurred';
//           break;
//         }

//       case DioExceptionType.badCertificate:
//         message = 'Bad Certificate';
//         break;

//       case DioExceptionType.badResponse:
//         final model = NetworkErrorModel.fromJson(
//           dioException.response?.data as Map<String, dynamic>,
//         );
//         message = model.message ?? 'Unexpected bad response';
//         if (message == 'Unauthenticated.') {
//           // AppConstants.accessToken = null;
//           myinjection<Box>().delete('login');
//         }
//         break;

//       case DioExceptionType.unknown:
//         message = 'Unexpected error occurred';
//         break;
//     }
//   }

//   @override
//   List<Object?> get props => [message, success];
// }
