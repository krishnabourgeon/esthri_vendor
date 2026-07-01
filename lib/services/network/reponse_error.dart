enum Error {
  notFound,
  badRequest,
  serverError,
  badResponse,
  jsonParsing,
}

class ResponseError {
  final Error key;
  final String? message;
  final Map? errors;

  const ResponseError({
    required this.key,
    this.errors,
    this.message,
  });
}
