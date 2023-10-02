import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:six_cash/controller/auth_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/appbar_home_element.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/logout_dialog.dart';
import 'package:six_cash/view/screens/profile/widget/menu_item.dart' as widget;
import 'package:six_cash/view/screens/profile/widget/profile_holder.dart';
import 'package:six_cash/view/screens/profile/widget/status_menu.dart';
import 'package:six_cash/view/screens/profile/widget/user_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    // UserInfo? userInfo = Get.find<ProfileController>().userInfo;

    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppbarHomeElement(title: 'profile'.tr),
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return ModalProgressHUD(
              inAsyncCall: authController.isLoading,
              progressIndicator: CircularProgressIndicator(color: Theme.of(context).primaryColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UserInfoWidget(),
                    ProfileHeader(title: 'setting'.tr),
                    Column(
                      children: [
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.editProfile, title: 'edit_profile'.tr),
                          onTap: () => Get.toNamed(RouteHelper.getEditProfileRoute()),
                        ),
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.pinChangeLogo, title: 'change_pin'.tr),
                          onTap: () => Get.toNamed(RouteHelper.getChangePinRoute()),
                        ),
                        if (AppConstants.languages.length > 1)
                          CustomInkWell(
                            child: widget.MenuItem(image: Images.languageLogo, title: 'change_language'.tr),
                            onTap: () => Get.toNamed(RouteHelper.getChoseLanguageRoute()),
                          ),
                        if (Get.find<SplashController>().configModel!.twoFactor!)
                          GetBuilder<ProfileController>(builder: (profileController) {
                            return profileController.isLoading
                                ? const TwoFactorShimmer()
                                : StatusMenu(
                                    title: 'two_factor_authentication'.tr,
                                    leading: Image.asset(Images.twoFactorAuthentication, width: 28.0),
                                  );
                          }),
                        if (authController.isBiometricSupported)
                          StatusMenu(
                            title: 'biometric_login'.tr,
                            leading: SizedBox(width: 25, child: Image.asset(Images.fingerprint)),
                            isAuth: true,
                          ),
                        CustomInkWell(
                          child: widget.MenuItem(
                            iconData: Icons.delete,
                            image: null,
                            title: 'delete_account'.tr,
                          ),
                          onTap: () {
                            showAnimatedDialog(
                                context,
                                CustomDialog(
                                  icon: Icons.question_mark_sharp,
                                  title: 'are_you_sure_to_delete_account'.tr,
                                  description: 'it_will_remove_your_all_information'.tr,
                                  onTapFalseText: 'no'.tr,
                                  onTapTrueText: 'yes'.tr,
                                  isFailed: true,
                                  onTapFalse: () => Get.back(),
                                  onTapTrue: () => Get.find<AuthController>().removeUser(),
                                  bigTitle: true,
                                ),
                                dismissible: false,
                                isFlip: true);
                          },
                        ),
                        GetBuilder<ProfileController>(
                          builder: (profileController) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                    child: Image.asset(
                                      Images.changeTheme,
                                      width: Dimensions.fontSizeOverOverLarge,
                                    ),
                                  ),
                                  Text('dark_mode'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 1,
                                    child: Switch(
                                      onChanged: profileController.toggleSwitch,
                                      value: profileController.isSwitched,
                                      activeColor: Colors.black26,
                                      activeTrackColor: Colors.grey,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    ProfileHeader(title: 'support'.tr),
                    Column(
                      children: [
                        if (((splashController.configModel!.companyEmail != null) || (splashController.configModel!.companyPhone != null)))
                          CustomInkWell(
                            child: widget.MenuItem(image: Images.supportLogo, title: '24_support'.tr),
                            onTap: () => Get.toNamed(RouteHelper.getSupportRoute()),
                          ),
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.questionLogo, title: 'faq'.tr),
                          onTap: () => Get.toNamed(RouteHelper.faq),
                        )
                      ],
                    ),
                    ProfileHeader(title: 'policies'.tr),
                    Column(
                      children: [
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.aboutUs, title: 'about_us'.tr),
                          onTap: () => Get.toNamed(RouteHelper.aboutUs),
                        ),
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.terms, title: 'terms'.tr),
                          onTap: () => Get.toNamed(RouteHelper.terms),
                        ),
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.privacy, title: 'privacy_policy'.tr),
                          onTap: () => Get.toNamed(RouteHelper.privacy),
                        )
                      ],
                    ),
                    ProfileHeader(title: 'account'.tr),
                    Column(
                      children: [
                        CustomInkWell(
                          child: widget.MenuItem(image: Images.logOut, title: 'logout'.tr),
                          onTap: () => Get.find<ProfileController>().logOut(context),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
