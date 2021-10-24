extension IndexedMap<T, E> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }
}

extension MapToList<K, V> on Map<K, V> {
  List<MapEntry<K, V>> toList() => this.entries.toList();
}

extension MapEntryList<K, V> on List<MapEntry<K, V>> {
  List<K> get keys => this.map((MapEntry<K, V> entry) => entry.key).toList();
  List<V> get values =>
      this.map((MapEntry<K, V> entry) => entry.value).toList();
  Map<K, V> toMap() => Map.fromEntries(this);
}
