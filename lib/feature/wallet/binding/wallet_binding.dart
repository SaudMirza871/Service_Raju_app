import 'package:ServiceRaju/feature/wallet/controller/wallet_controller.dart';
import 'package:ServiceRaju/feature/wallet/repository/wallet_repo.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController(
        walletRepo:
            WalletRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }
}
