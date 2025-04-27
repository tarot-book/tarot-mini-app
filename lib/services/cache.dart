typedef Loader<T> = Future<T> Function(String url);

Loader<T> cacheLoader<T>(Loader<T> loader) {
  final cache = <String, Future<T>>{};

  return (String url) {
    if (cache.containsKey(url)) {
      return cache[url]!;
    }

    final future = loader(url);
    cache[url] = future;

    future.catchError((error, stackTrace) {
      cache.remove(url);
      throw error; // Re-throw the error to keep the Future's error state
    });

    return future;
  };
}
