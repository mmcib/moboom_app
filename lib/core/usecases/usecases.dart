import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moboom_app/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

abstract class StreamedUseCase<Type, Params> {
  Stream<Either<Failure, Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
