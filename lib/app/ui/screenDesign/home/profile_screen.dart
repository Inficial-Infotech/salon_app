import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_app/app/data/model/bottomSheetModel/bottom_sheet_model.dart';
import 'package:salon_app/app/translations/string_constant/constants.dart';
import 'package:salon_app/app/ui/screenDesign/Auth/sign_in.dart';
import 'package:salon_app/app/ui/constants/image_constants.dart';
import 'package:salon_app/app/ui/theme/app_colors.dart';
import 'package:salon_app/app/ui/theme/app_text_theme.dart';
import 'package:salon_app/app/ui/utils/common_widgets.dart';
import 'package:salon_app/app/ui/utils/dialogs.dart';
import 'package:salon_app/app/ui/utils/math_utils.dart';
import 'package:salon_app/app/controller/home_controller/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(getSize(30)),
        child: Column(
          children: [
            SizedBox(
              height: getSize(20),
            ),
            getProfileImage(context),
            SizedBox(
              height: getSize(15),
            ),
            Text(
              controller.user.userName,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: getSize(15),
            ),
            Text(
              controller.user.emailId,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: getSize(15),
            ),
            getFirstContainer(context),
            SizedBox(
              height: getSize(20),
            ),
            getSecondContainer(context),
            SizedBox(
              height: getSize(20),
            ),
            getLanguageTranslationContainer(context),
            SizedBox(
              height: getSize(20),
            ),
            getLogoutContainer(context)
          ],
        ),
      ),
    );
  }

  Center getProfileImage(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return Container(
                height: getSize(120),
                width: getSize(120),
                // padding: EdgeInsets.all(getSize(15)),
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(getSize(60)),
                  color: ColorConstants.primaryColor,
                  boxShadow: getBoxShadow(context),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(60)),
                  child: !isNullEmptyOrFalse(controller.profileImage)
                      ? Image.file(controller.profileImage)
                      : Image.asset(
                          logo,
                          fit: BoxFit.fill,
                        ),
                ),
              );
            },
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                //Image picker done.
                showprofileImageBottomSheet(context, (img) async {
                  controller.setSelectedImage(img);
                });
              },
              child: Container(
                padding: EdgeInsets.all(getSize(2)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.primaryColor,
                ),
                child: Icon(
                  Icons.add,
                  color: ColorConstants.whiteColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container getLanguageTranslationContainer(context) {
    return Container(
      padding: EdgeInsets.all(getSize(20)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getSize(25),
          ),
          color: Theme.of(context).backgroundColor,
          boxShadow: getBoxShadow(context)),
      child: Column(
        children: [
          getVariousOption(
              icon: Icons.language,
              text: ChangeAppLanguage.tr,
              onClick: () {
                commonBottomSheet(context, list: controller.list,
                    onClick: (index) {
                  if (index == 1) {
                    Get.updateLocale(Locale('hi', 'IN'));
                  } else {
                    Get.updateLocale(Locale('en', 'US'));
                  }
                });
              }),
        ],
      ),
    );
  }

  Container getLogoutContainer(context) {
    return Container(
      padding: EdgeInsets.all(getSize(20)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getSize(25),
          ),
          color: Theme.of(context).backgroundColor,
          boxShadow: getBoxShadow(context)),
      child: Column(
        children: [
          getVariousOption(
              icon: Icons.logout,
              text: LogOut.tr,
              onClick: () {
                Get.offAll(SignIn());
              }),
        ],
      ),
    );
  }

  Container getSecondContainer(context) {
    return Container(
      padding: EdgeInsets.all(getSize(20)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getSize(25),
          ),
          color: Theme.of(context).backgroundColor,
          boxShadow: getBoxShadow(context)),
      child: Column(
        children: [
          getVariousOption(
              icon: Icons.notification_important, text: NOTIFICATION.tr),
          SizedBox(
            height: getSize(15),
          ),
          getVariousOption(icon: Icons.share, text: InviteFriends.tr),
          SizedBox(
            height: getSize(15),
          ),
          getVariousOption(icon: Icons.settings, text: Setting.tr),
          SizedBox(
            height: getSize(15),
          ),
          getVariousOption(icon: Icons.room_service, text: TermsOfServices.tr),
        ],
      ),
    );
  }

  Container getFirstContainer(context) {
    return Container(
      padding: EdgeInsets.all(getSize(20)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getSize(25),
          ),
          color: Theme.of(context).backgroundColor,
          boxShadow: getBoxShadow(context)),
      child: Column(
        children: [
          getVariousOption(icon: Icons.payment, text: PaymentMethods.tr),
          SizedBox(
            height: getSize(15),
          ),
          getVariousOption(icon: Icons.info, text: AccountInforamtion.tr),
        ],
      ),
    );
  }

  InkWell getVariousOption({IconData icon, String text, VoidCallback onClick}) {
    return InkWell(
      onTap: onClick,
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorConstants.primaryColor,
          ),
          SizedBox(
            width: getSize(20),
          ),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
