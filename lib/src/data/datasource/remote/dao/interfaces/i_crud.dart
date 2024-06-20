abstract interface class ICRUD<T> {
  Future<bool> insert(T data);
  Future<bool> delete(T data);
  Future<bool> update(T data);
  Future<List<T>> getAll();
}
