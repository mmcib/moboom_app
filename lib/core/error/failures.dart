import 'package:equatable/equatable.dart';
import 'package:moboom_app/generated/l10n.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  String getMessage();
}

class ServerFailure extends Failure {
  ServerFailure({
    this.statusCode,
    this.errorMessage,
    this.reason,
  });

  final int? statusCode;
  final String? errorMessage;
  final String? reason;

  @override
  String getMessage() {
    if (errorMessage != null) {
      return errorMessage!;
    }
    return 'Server failure ($statusCode), while calling $reason';
  }
}

class ClientFailure extends Failure {
  ClientFailure(this.exception, {this.reason});

  final dynamic exception;
  final String? reason;

  @override
  String getMessage() {
    return 'Client failure: ${exception.toString()}';
  }
}

class AuthFailure extends Failure {
  AuthFailure();

  @override
  String getMessage() {
    return 'Auth failure';
  }
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure();

  @override
  String getMessage() {
    return S.current.noInternetConnection;
  }
}
