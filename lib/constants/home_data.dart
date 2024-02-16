import 'package:task/models/home_model.dart';

class HomeData {
  static List<HomeCategoriesModel> getHomeCategoriesData() {
    return [
      HomeCategoriesModel("All", 1),
      HomeCategoriesModel("Important", 2),
      HomeCategoriesModel("Goals", 3),
      HomeCategoriesModel("Task", 4),
      HomeCategoriesModel("Product Idea", 5),
    ];
  }
}
