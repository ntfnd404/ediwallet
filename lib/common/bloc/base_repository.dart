abstract class BaseRepository<T> {
  Future<List<T>> fetchItems([int startIndex = 0]);
}
