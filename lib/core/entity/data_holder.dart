typedef DataTransform<T, S> = T Function(S data);

class DataHolder<T>{
  final T? data;
  final Exception? exception;

  DataHolder(this.data, this.exception);

  factory DataHolder.withData(T data) => DataHolder(data, null);
  factory DataHolder.emptyData() => DataHolder(null, null);
  factory DataHolder.withException(Exception e) => DataHolder(null, e);

  bool get hasException => exception != null;
  bool get hasData => data != null;


  DataHolder<S> transform<S>(DataTransform<S, T> transform){
    if(hasException){
      return DataHolder.withException(exception!);
    } else {
      if(hasData){
        try {
          return DataHolder.withData(
              transform(data!));
        } on Exception catch(e){
          return DataHolder.withException(e);
        }
      } else {
        return DataHolder.emptyData();
      }
    }
  }
}
