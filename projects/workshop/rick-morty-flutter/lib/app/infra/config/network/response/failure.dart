abstract class Failure {
  String get code;
  String get message;
  dynamic get response;
  StackTrace? get stackTrace;
}

class DataFailure implements Failure {
  final String errorMessage;
  final String errorCode;

  DataFailure(this.errorMessage, {this.errorCode = ''});

  @override
  String get code => errorCode;

  @override
  String get message => errorMessage;

  @override
  dynamic get response => null;

  @override
  StackTrace? get stackTrace => StackTrace.empty;

  @override
  String toString() => message;
}
