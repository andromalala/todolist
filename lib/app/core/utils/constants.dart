// debug tools
String get logTrace =>
    '[LOG_TRACE] ${StackTrace.current.toString().split("\n").toList()[1].split("      ").last}';

enum HttpStatus {
  ok,
  created,
  accepted,
  noContent,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  methodNotAllowed,
  conflict,
  preconditionFailed,
  unsupportedMediaType,
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
}

const Map<HttpStatus, int> httpStatusCodes = {
  HttpStatus.ok: 200,
  HttpStatus.created: 201,
  HttpStatus.accepted: 202,
  HttpStatus.noContent: 204,
  HttpStatus.badRequest: 400,
  HttpStatus.unauthorized: 401,
  HttpStatus.forbidden: 403,
  HttpStatus.notFound: 404,
  HttpStatus.methodNotAllowed: 405,
  HttpStatus.conflict: 409,
  HttpStatus.preconditionFailed: 412,
  HttpStatus.unsupportedMediaType: 415,
  HttpStatus.internalServerError: 500,
  HttpStatus.notImplemented: 501,
  HttpStatus.badGateway: 502,
  HttpStatus.serviceUnavailable: 503,
  HttpStatus.gatewayTimeout: 504,
};

enum SortType { dateNewest, dateOldest, alphabeticalAsc, alphabeticalDesc }
