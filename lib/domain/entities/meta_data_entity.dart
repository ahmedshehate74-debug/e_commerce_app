class MetadataEntity {
  final int currentPage;
  final int numberOfPages;
  final int limit;
  final int? nextPage;

  MetadataEntity({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    this.nextPage,
  });
}