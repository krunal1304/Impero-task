class ApiStatus<T> {
  late Status status;
  late T data;
  late String message;
  late dynamic error;
  late int progress;

  ApiStatus.completed(this.data) : status = Status.COMPLETED;
  ApiStatus.error(this.message) : status = Status.ERROR;
  ApiStatus.none() : status = Status.NONE;
}

enum Status { COMPLETED, ERROR, NONE }