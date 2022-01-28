
import '../controller/controller.dart';
import 'package:get/get.dart';

class PlayController extends GetxController {
  Controller controller = Get.put(Controller());
  @override
  void onReady() {
    Future.delayed(Duration(milliseconds: 3500), () {
      shouldShow.value = true;
    });
    super.onReady();
  }

  @override
  void onInit() {
    controller.playTimerSound();
    shouldShow.value = false;
    super.onInit();
  }

  var shouldShow = false.obs;
}
