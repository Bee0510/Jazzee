class cartItem {
  final String id;
  final String name;
  final double mrp;
  final double price;
  final String imageUrl;
  int quantity;

  cartItem(
      {required this.id,
      required this.name,
      required this.mrp,
      required this.price,
      required this.imageUrl,
      this.quantity = 1});
}
