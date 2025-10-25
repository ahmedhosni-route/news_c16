sealed class ApiResult<L, R> {
  R? success;
  L? error;
  ApiResult({this.success, this.error});
}

class Success extends ApiResult {
  Success({super.success});
}

class Error extends ApiResult {
  Error({super.error});
}
