import 'dart:developer' as developer;

void logError(String message, [dynamic error, StackTrace? stackTrace]) {
  developer.log(message, name: 'piaoxingqiu.app.error', error: error, stackTrace: stackTrace);
}
