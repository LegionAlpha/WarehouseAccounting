enum ProductStatus {
  available,
  taken;

  bool get isAvailable => this == ProductStatus.available;
  bool get isTaken => this == ProductStatus.taken;
}
