abstract class BaseService {
  final _cache = <String, Future<dynamic>>{};

  Future<T> fetchWithCache<T>(String key, Future<T> Function() loader) {
    // If the result is already cached, return it
    if (_cache.containsKey(key)) {
      return _cache[key] as Future<T>;
    }

    // Otherwise, start the real request and cache it
    final future = loader();
    _cache[key] = future;

    // If the request fails, remove it from the cache
    future.catchError((error, stackTrace) {
      _cache.remove(key);
      throw error; 
    });

    return future;
  }
}
