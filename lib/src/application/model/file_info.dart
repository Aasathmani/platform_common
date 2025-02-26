class FileInfo {
  final String id;
  final String name;
  final String url;
  final String? contentType;
  final int size;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileInfo({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    this.contentType,
    this.size = 0,
  });
}
