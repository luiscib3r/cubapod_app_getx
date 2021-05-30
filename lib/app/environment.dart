class Environment {
  final String apiUrl;

  Environment({
    required this.apiUrl,
  });

  factory Environment.production() => Environment(
        apiUrl: 'https://api.cubapod.net',
      );
}
