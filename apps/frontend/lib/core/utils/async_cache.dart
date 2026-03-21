class AsyncCache<T> {
  AsyncCache({required this.ttl});

  final Duration ttl;
  final Map<String, _CacheEntry<T>> _cache = <String, _CacheEntry<T>>{};
  final Map<String, Future<T>> _inflight = <String, Future<T>>{};

  Future<T> get(
    String key,
    Future<T> Function() loader, {
    bool force = false,
  }) async {
    if (!force) {
      final cached = _cache[key];
      if (cached != null && !cached.isExpired) {
        return cached.value;
      }
      final inflight = _inflight[key];
      if (inflight != null) {
        return inflight;
      }
    }

    final future = loader();
    _inflight[key] = future;
    try {
      final value = await future;
      _cache[key] = _CacheEntry<T>(value, DateTime.now().add(ttl));
      return value;
    } finally {
      _inflight.remove(key);
    }
  }

  void set(String key, T value, {Duration? ttlOverride}) {
    _cache[key] = _CacheEntry<T>(value, DateTime.now().add(ttlOverride ?? ttl));
  }

  void invalidate(String key) => _cache.remove(key);

  void clear() => _cache.clear();
}

class _CacheEntry<T> {
  _CacheEntry(this.value, this.expiresAt);

  final T value;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
