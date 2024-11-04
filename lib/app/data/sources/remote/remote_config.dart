abstract class RemoteConfig {
  /// Les différentes URL possibles
  /// URL pour la production

  /// URL pour l'api
  static String baseUrl = "https://my-api-server-zco6.onrender.com";
}

/// [RemoteEndpoint]fournit les points d'accès (endpoints) pour les api.
/// * Chaque endpoint est représenté par une variable statique avec une URL basée sur [RemoteConfig.baseUrl]`
///   et un chemin spécifique pour chaque endpoint.
/// * Certains endpoints sont paramétrés dynamiquement en utilisant des méthodes statiques
///   pour générer l'URL complète en fonction d'un ID ou d'autres valeurs.
abstract class RemoteEndpoint {
  static String addTask = "${RemoteConfig.baseUrl}/tasks/create";

  static String deleteTask(String id) => "${RemoteConfig.baseUrl}/tasks/$id";

  static String getAllTask = "${RemoteConfig.baseUrl}/tasks";

  static String updateTask(String id) => "${RemoteConfig.baseUrl}/tasks/$id";
}
