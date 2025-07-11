import 'package:get/get.dart';

class UserController extends GetxController {
  var userId = ''.obs;
  var userName = ''.obs;
  var isLoggedIn = false.obs;

  void setUser(String id, String name) {
    userId.value = id;
    userName.value = name;
    isLoggedIn.value = true;
  }

  void clearUser() {
    userId.value = '';
    userName.value = '';
    isLoggedIn.value = false;
  }
}
