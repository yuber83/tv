///Recordemos que en capa dominion nosotros que trabajar con abstracciones los cuales van a ser implementdas en la capa de datos

abstract class ConnectivityRepository {
  Future<void> initialize();
  bool get hasInternet;

  Stream<bool> get onInternetChanged;
}
