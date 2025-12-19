import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awwaab_app/core/common/api_result.dart';
import 'package:awwaab_app/core/common/custom_exception.dart';
import 'package:dio/dio.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } on TimeoutException catch (_) {
    return Fail(NoInternetError());
  } on DioException catch (ex) {
    dynamic message;

    try {
      final data = ex.response?.data;

      if (data is String) {
        final decoded = json.decode(data);
        if (decoded is Map<String, dynamic>) {
          message = decoded['message'] ?? "حدث خطأ غير متوقع";
        } else {
          message = "حدث خطأ غير متوقع";
        }
      } else if (data is Map<String, dynamic>) {
        message = data['message'] ?? "حدث خطأ غير متوقع";
      } else {
        message = "حدث خطأ غير متوقع";
      }
    } catch (_) {
      message = "حدث خطأ غير متوقع";
    }

    log('$message');

    if (ex.response != null) {
      return Fail(
        ServerError(
          statusCode: ex.response?.statusCode,
          serverMessage: message.toString(),
        ),
      );
    } else {
      return Fail(DioHttpException(ex));
    }
  } on IOException catch (_) {
    return Fail(NoInternetError());
  } on Exception catch (ex) {
    return Fail(ex);
  }
}
