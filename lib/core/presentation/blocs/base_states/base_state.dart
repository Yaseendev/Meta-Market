import 'package:equatable/equatable.dart';
import 'package:supermarket/core/errors/failure.dart';

enum BaseStatus {
  initial,
  inProgress,
  success,
  failure,
  noConnection,
}

class BaseState<T> extends Equatable {
  final BaseStatus status;
  final T? item;
  final T? tempItem;
  final Failure? failure;
  final bool? refreshFlag;

  const factory BaseState.init() = InitState<T>;

  const factory BaseState.loading() = LoadingState<T>;

  const factory BaseState.success({T? data}) = SuccessState<T>;

  const factory BaseState.error({Failure? fail}) = ErrorState<T>;

  const factory BaseState.noConnection() = NoConnectionState<T>;

  BaseState<T> setInitialState() => BaseState<T>(
        status: BaseStatus.initial,
      );

  BaseState<T> setInProgressState() => BaseState<T>(
        status: BaseStatus.inProgress,
      );
  BaseState<T> setSuccessState(T item) =>
      BaseState<T>(status: BaseStatus.success, item: item);

  BaseState<T> setFailureState(Failure failure, [bool? rFlag]) => BaseState<T>(
      status: BaseStatus.failure, failure: failure, refreshFlag: rFlag);

  bool get isInProgress => status == BaseStatus.inProgress;

  bool get isFailure => status == BaseStatus.failure;

  bool get isSuccess => status == BaseStatus.success;

  bool get isInitial => status == BaseStatus.initial;

  const BaseState({
    this.status = BaseStatus.initial,
    this.item,
    this.failure,
    this.tempItem,
    this.refreshFlag,
  });

  BaseState<T> copyWith({
    BaseStatus? status,
    T? item,
    T? tempItem,
    Failure? failure,
    bool? refreshFlag,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      item: item ?? this.item,
      failure: failure ?? this.failure,
      tempItem: tempItem ?? this.tempItem,
      refreshFlag: refreshFlag ?? this.refreshFlag,
    );
  }

  @override
  List<Object?> get props => [status, item, failure, refreshFlag];
}

class InitState<T> extends BaseState<T> {
  const InitState() : super(status: BaseStatus.initial);
}

class LoadingState<T> extends BaseState<T> {
  const LoadingState() : super(status: BaseStatus.inProgress);
}

class SuccessState<T> extends BaseState<T> {
  final T? data;

  const SuccessState({this.data})
      : super(
          item: data,
          status: BaseStatus.success,
        );
}

class ErrorState<T> extends BaseState<T> {
  final Failure? fail;

  const ErrorState({this.fail})
      : super(
          failure: fail,
          status: BaseStatus.failure,
        );
}

class NoConnectionState<T> extends BaseState<T> {
  const NoConnectionState() : super(status: BaseStatus.noConnection);
}
