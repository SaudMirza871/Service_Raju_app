import 'package:get/get.dart';
import 'package:ServiceRaju/feature/conversation/controller/conversation_controller.dart';
import 'package:ServiceRaju/feature/conversation/repo/conversation_repo.dart';

class ConversationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationController(
        conversationRepo: ConversationRepo(apiClient: Get.find())));
  }
}
