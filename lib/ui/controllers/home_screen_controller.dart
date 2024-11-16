import 'package:get/get.dart';

class HomeScreenController extends GetxController{
  RxInt selectedIndex = 0.obs;

  void updateSelectedIndex(value){
    selectedIndex.value = value;
    update();
  }
}