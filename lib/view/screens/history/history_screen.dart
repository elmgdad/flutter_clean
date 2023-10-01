import 'package:six_cash/controller/transaction_history_controller.dart';
import 'package:six_cash/data/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/base/appbar_home_element.dart';

class HistoryScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Transactions? transactions;
  HistoryScreen({Key? key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TransactionHistoryController>().setIndex(0);
    return Scaffold(
      appBar: AppbarHomeElement(title: 'history'.tr),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            // await Get.find<TransactionHistoryController>().getTransactionData(1,reload: true);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
          ),
        ),
      ),
    );
  }
}
