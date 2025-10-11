// category
// The category you want to get headlines for. Possible options:
// business
// entertainment
// general
// health
// science
// sports
// technology.

class Category {
  String id;
  String name;
  String image;
  Category({required this.id, required this.image, required this.name});

  static List<Category> categories = [
    Category(
        id: "general", image: "assets/images/general.png", name: "General"),
    Category(
        id: "business", image: "assets/images/business.png", name: "Business"),
    Category(id: "sports", image: "assets/images/sports.png", name: "Sports"),
    Category(
        id: "technology",
        image: "assets/images/technology.png",
        name: "technology"),
    Category(
        id: "entertainment",
        image: "assets/images/entertainment.png",
        name: "Entertainment"),

    Category(id: "health", image: "assets/images/health.png", name: "Health"),
    Category(
        id: "science", image: "assets/images/science.png", name: "Science"),

  ];
}
