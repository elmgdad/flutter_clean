import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/appbar_home_element.dart';
import 'package:six_cash/view/base/no_data_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHomeElement(title: 'notification'.tr),
      body: RefreshIndicator(
        onRefresh: () async {
          // await Get.find<NotificationController>().getNotificationList(true, isUpdate: true);
        },
        child: const NoDataFoundScreen(),
      ),
    );
  }
}
