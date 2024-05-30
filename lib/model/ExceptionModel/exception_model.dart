import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String handleStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request.';
    case 401:
      return 'Authentication failed.';
    case 403:
      return 'The authenticated user is not allowed to access the specified API endpoint.';
    case 404:
      return 'The requested resource does not exist.';
    case 405:
      return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
    case 415:
      return 'Unsupported media type. The requested content type or version number is invalid.';
    case 422:
      return 'Data validation failed.';
    case 429:
      return 'Too many requests.';
    case 500:
      return 'Internal server error.';
    default:
      return 'Oops something went wrong!';
  }
}

class Exceptions {
  late String errorMessage;

  void handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = handleStatusCode(dioError.response?.statusCode);
        break;
      case DioExceptionType.connectionError:
        if (dioError.message!.contains('SocketException')) {
          errorMessage = 'No Internet.';
        } else {
          errorMessage = 'Unexpected error occurred.';
        }
        break;
      default:
        errorMessage = 'Something went wrong.';
        break;
    }
  }
}

Future<void> showToast(String message) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
