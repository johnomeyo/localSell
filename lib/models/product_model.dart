class Product {
  final String name;
  final String size;
  final String price;
  final String category;
  final String description;
  final String imageUrl;
  final String condition;
  List<dynamic> carouselUrls;

  Product( 
      {required this.condition,
      required this.size,
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrl,
      required this.carouselUrls,
      required this.category,
      });
}
