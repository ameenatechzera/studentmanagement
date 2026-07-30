class EasebuzzAccessKeyResponse {
  final bool success;      // true if status == 1
  final String? accessKey; // present on success
  final String? errorDesc; // present on failure
  final Map<String, dynamic> raw;

  EasebuzzAccessKeyResponse({
    required this.success,
    this.accessKey,
    this.errorDesc,
    required this.raw,
  });
}
