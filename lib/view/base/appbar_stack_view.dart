import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/localization_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';

import 'package:six_cash/view/base/rounded_button.dart';

import 'custom_logo_white.dart';

class AppbarStackView extends StatelessWidget {
  const AppbarStackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String languageText = AppConstants.languages[Get.find<LocalizationController>().selectedIndex].languageName!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomLogoWhite(height: 50.0, width: 50.0),
          RoundedButton(
            buttonText: languageText,
            onTap: AppConstants.languages.length > 1
                ? () {
                    Get.toNamed(RouteHelper.getChoseLanguageRoute());
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
