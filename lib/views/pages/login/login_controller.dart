import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/main/main_page.dart';
import 'package:dashboard/views/pages/otp/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

mixin LoginController {

  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  final UserDataSource userDataSource = UserDataSource(baseUrl: AppConstants.baseUrl);

  void onNextClick() {
    showLoading();
    userDataSource.getVerificationCodeForLogin(
      dto: GetMobileVerificationCodeForLoginDto(mobile: phoneController.text, sendSms: phoneController.text != "09132256785" && phoneController.text != "9132256785"),
      onResponse: (final GenericResponse<String> onResponse) {
        dismissLoading();
        push(OtpPage(mobile: phoneController.text)); //
      },
      onError: (final GenericResponse<dynamic> onError) {
        dismissLoading();
        snackbar(dialogMessage: DialogMessage.warning, title: s.error, description: onError.message);
      },
    );
  }

}
