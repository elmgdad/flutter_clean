import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/home_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/view/screens/home/widget/app_bar_base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    if (reload) {
      Get.find<SplashController>().getConfigData();
    }

    Get.find<ProfileController>().profileData(reload: reload);
    // Get.find<BannerController>().getBannerList(reload);
    // Get.find<RequestedMoneyController>().getRequestedMoneyList(reload, isUpdate: reload);
    // Get.find<RequestedMoneyController>().getOwnRequestedMoneyList(reload, isUpdate: reload);
    // Get.find<TransactionHistoryController>().getTransactionData(1, reload: reload);
    // Get.find<WebsiteLinkController>().getWebsiteList(reload, isUpdate: reload);
    // Get.find<NotificationController>().getNotificationList(reload, isUpdate: reload);
    // Get.find<TransactionMoneyController>().getPurposeList(reload, isUpdate: reload);
    // Get.find<TransactionMoneyController>().getWithdrawMethods(isReload: reload);
    // Get.find<RequestedMoneyController>().getWithdrawHistoryList(reload: false);
  }

  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          appBar: const AppBarBase(),
          body: RefreshIndicator(
            onRefresh: () async => await _loadData(context, true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: GetBuilder<SplashController>(builder: (splashController) {
                return const Column(children: [
                  SizedBox(
                    height: 10,
                  )
                ]);
              }),
            ),
          ));
    });
  }
}
