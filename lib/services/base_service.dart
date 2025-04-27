import 'dart:async';

abstract class BaseService {
  final _cache = <String, Future<dynamic>>{};

  Future<T> fetchWithCache<T>(String key, Future<T> Function() loader) {
    if (_cache.containsKey(key)) {
      return _cache[key] as Future<T>;
    }

    final future = loader();
    _cache[key] = future;

    // If the request fails, remove it from the cache and re-throw preserving the stack trace
    future.catchError((error, stackTrace) {
      _cache.remove(key);
      Error.throwWithStackTrace(error, stackTrace);
    });

    return future;
  }
}
