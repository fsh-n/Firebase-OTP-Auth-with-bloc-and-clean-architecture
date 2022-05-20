abstract class DataLogger {
  void logException(String? exception);
  void logData(String? data);
}

class DefaultDataLogger {
  static void logData(String? data) {
    print('Data : ' + data!); // Remove in production
  }

  static void logException(String? exception) {
    print('Exception : ' + exception!); // Remove in production
  }
}
