

import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef ResultInt = ResultFuture<int>;

typedef DataMap = Map<String, dynamic>;
