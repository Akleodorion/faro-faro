import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class ApiCallMethods {
  bool isStatusCodeOK(http.Response response);
  bool isStatusCodeBad(http.Response response);
  extractBodyFromResponse(http.Response response, String modelName);
  String extractErrorMessageFromReponse(http.Response response);
}

class ApiCallMethodsImpl implements ApiCallMethods {
  @override
  extractBodyFromResponse(http.Response response, String modelName) {
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return json.decode(response.body);
    }
    if (statusCode == 201) {
      return json.decode(response.body)[modelName];
    }
    throw ServerException(errorMessage: "Une erreur s'est produite");
  }

  @override
  String extractErrorMessageFromReponse(http.Response response) {
    if (response.statusCode == 404) {
      return json.decode(response.body)["error"];
    }

    if (response.statusCode == 422) {
      return json.decode(response.body)["errors"][0];
    }
    throw ServerException(errorMessage: "Une erreur s'est produite");
  }

  @override
  bool isStatusCodeBad(http.Response response) {
    final bool statusCodeNotFound = response.statusCode == 404;
    final bool statusCodeUnprocessable = response.statusCode == 422;
    final bool statusCodeIsBad = statusCodeNotFound || statusCodeUnprocessable;
    return statusCodeIsBad;
  }

  @override
  bool isStatusCodeOK(http.Response response) {
    final bool statusCodeOk = response.statusCode == 200;
    final bool statusCodeCreated = response.statusCode == 201;
    final bool statusCodeIdGood = statusCodeOk || statusCodeCreated;

    return statusCodeIdGood;
  }
}
