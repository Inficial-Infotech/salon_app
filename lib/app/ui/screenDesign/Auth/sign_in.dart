import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salon_app/app/controller/auth_controller/signin_controller.dart';
import 'package:salon_app/app/routes/app_pages.dart';
import 'package:salon_app/app/translations/string_constant/constants.dart';
import 'package:salon_app/app/ui/screenDesign/Auth/sign_up.dart';
import 'package:salon_app/app/ui/screenDesign/home/home_page.dart';
import 'package:salon_app/app/ui/constants/EnumConstants.dart';
import 'package:salon_app/app/ui/constants/image_constants.dart';
import 'package:salon_app/app/ui/theme/app_colors.dart';
import 'package:salon_app/app/ui/theme/app_text_theme.dart';
import 'package:salon_app/app/ui/utils/app_button.dart';
import 'package:salon_app/app/ui/utils/common_textfield.dart';
import 'package:salon_app/app/ui/utils/common_widgets.dart';
import 'package:salon_app/app/ui/utils/dialogs.dart';
import 'package:salon_app/app/ui/utils/math_utils.dart';
import 'package:salon_app/app/ui/utils/validator_utils.dart';

class SignIn extends StatelessWidget {
  final controller = Get.put<SignInContoller>(SignInContoller());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: getSize(300),
            padding: EdgeInsets.symmetric(
              vertical: getSize(70),
            ),
            color: ColorConstants.primaryColor,
            child: Image.asset(
              logo,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: getSize(250)),
            padding: EdgeInsets.all(getSize(30)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: ColorConstants.bgColor,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: GetBuilder(
                    init: controller,
                    builder: (_) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              LogIn.tr,
                              style: black18TitleTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: getSize(30),
                          ),
                          getEmailTextField(),
                          SizedBox(
                            height: getSize(30),
                          ),
                          getPasswordTextField(),
                          SizedBox(
                            height: getSize(20),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              ForgotPassword.tr,
                              style: black16TextStyle,
                            ),
                          ),
                          SizedBox(
                            height: getSize(20),
                          ),
                          getLogInButton(),
                          SizedBox(
                            height: getSize(20),
                          ),
                          RichText(
                            text: TextSpan(
                              text: YouDontHaveAnAccount.tr,
                              style: black16TextStyle,
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(Routes.SIGNUP);
                                      // Get.to(SignUp());
                                    },
                                  text: SIGNUP.tr,
                                  style: black16TextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppButton getLogInButton() {
    return AppButton.flat(
      fitWidth: true,
      onTap: () async {
        if (formKey.currentState.validate()) {
          controller.loading.value = true;

          controller.loginCall((value) {
            if (value) {
              Get.to(HomePage());
            } else {
              showToast(msg: LOGINPASSWORDMIGHTBEWRONG.tr);
            }
          });
        } else {
          controller.autoValidate.value = true;
        }
      },
      text: LogIn.tr,
      backgroundColor: ColorConstants.primaryColor,
    );
  }

  CommonTextfield getPasswordTextField() {
    return CommonTextfield(
      focusNode: controller.passwordFocusNode,
      textOption: TextFieldOption(
        isSecureTextField: true,
        prefixWid:
            getCommonIconWidget(imageName: lock, imageType: IconSizeType.small),
        //Image.asset(profileEmail,),

        hintText: EnterPassword.tr,
        inputController: controller.passwordController,
        errorBorder: controller.isPasswordValid.value
            ? null
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(11)),
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),

        formatter: [],
      ),
      textCallback: (text) {
        if (controller.autoValidate.value) {
          if (text.isEmpty) {
            controller.isPasswordValid.value = false;
          } else {
            controller.isPasswordValid.value = true;
          }
          formKey.currentState.validate();
        }
      },
      validation: (text) {
        if (text.isEmpty) {
          controller.isPasswordValid.value = false;

          return EnterPassword.tr;
        } else {
          return null;
        }
      },
      inputAction: TextInputAction.done,
      onNextPress: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }

  CommonTextfield getEmailTextField() {
    return CommonTextfield(
      focusNode: controller.emailFocusNode,
      textOption: TextFieldOption(
        prefixWid: getCommonIconWidget(
            imageName: userIcon, imageType: IconSizeType.small),
        //Image.asset(profileEmail,),

        hintText: EnterEmail.tr,
        inputController: controller.emailController,
        errorBorder: controller.isEmailValid.value
            ? null
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(11)),
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),

        formatter: [],
      ),
      textCallback: (text) {
        if (controller.autoValidate.value) {
          if (text.isEmpty) {
            controller.isEmailValid.value = false;
          } else if (!ValidationUtils.validateEmail(text)) {
            controller.isEmailValid.value = false;
          } else {
            controller.isEmailValid.value = true;
          }
          controller.formKey.currentState.validate();
        }
      },
      validation: (text) {
        if (text.isEmpty) {
          controller.isEmailValid.value = false;

          return EnterEmail.tr;
        } else if (!ValidationUtils.validateEmail(text)) {
          return EnterValidEmail.tr;
        } else {
          return null;
        }
      },
      inputAction: TextInputAction.next,
      onNextPress: () {
        controller.passwordFocusNode.requestFocus();
      },
    );
  }
}
