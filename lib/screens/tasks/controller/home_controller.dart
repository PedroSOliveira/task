
import 'package:task/constants/home_data.dart';
import 'package:task/models/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
 List<HomeCategoriesModel> categoriesData =  HomeData.getHomeCategoriesData();

  int currentPage = 0;
}


