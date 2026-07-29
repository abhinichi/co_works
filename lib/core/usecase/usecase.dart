import 'package:co_works/core/error/failures.dart';
import 'package:dartz/dartz.dart';

/// Base contract for every use case (a.k.a. interactor) in the domain layer.
///
/// A use case represents a single business action. It depends only on
/// repository *interfaces*, returns `Either<Failure, Type>`, and contains no
/// Flutter/UI code — which makes it trivial to unit test.
///
/// * [T]      – the success value type.
/// * [Params] – the input. Use [NoParams] when the action takes no arguments.
abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Placeholder for use cases that require no parameters.
class NoParams {
  const NoParams();
}
