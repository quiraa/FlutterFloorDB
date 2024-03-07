abstract class DataState<T> {
  final T? data;
  final String? errorMessage;

  const DataState({this.data, this.errorMessage});
}

class DataSucess<T> extends DataState<T> {
  const DataSucess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(String errorMessage) : super(errorMessage: errorMessage);
}
