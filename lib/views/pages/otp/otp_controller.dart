import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

mixin OtpController {
  String pinValue = "";
  late Timer timer;
  RxInt counter = 59.obs;
  final UserDataSource userDataSource = UserDataSource(baseUrl: AppConstants.baseUrl);
  String phoneNumber = "";

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (final Timer timer) {
      counter.value--;
      if (counter.value == 0) timer.cancel();
    });
  }

  void onConfirmationClick() {
    if (pinValue.length != 4) {
      snackbar(dialogMessage: DialogMessage.warning, title: s.error, description: s.pleaseEnterFourDigitPin);
    } else {
      showLoading();
      userDataSource.verifyCodeForLogin(
        dto: VerifyMobileForLoginDto(mobile: phoneNumber, verificationCode: pinValue),
        onResponse: (final GenericResponse<UserReadDto> onResponse) {
          setData(UtilitiesConstants.token, "Bearer ${onResponse.result?.token}");
          setData(AppConstants.userId, onResponse.result?.id);
          App.userReadDto = onResponse.result;
          dismissLoading();
          timer.cancel();
          setData(AppConstants.userLogin, true);
          offAll(const MainPage());
        },
        onError: (final GenericResponse<dynamic> onError) {
          dismissLoading();
          snackbar(
            title: s.error,
            description: s.codeError,
            dialogMessage: DialogMessage.warning,
          );
        },
      );
    }
  }

  void onEditPhoneNumberClick() {
    timer.cancel();
    back();
  }

  void onResendCode() async {
    showLoading();
    await userDataSource.getVerificationCodeForLogin(
      // dto: GetMobileVerificationCodeForLoginDto(mobile: phoneNumber, sendSms: true),
      dto: GetMobileVerificationCodeForLoginDto(mobile: phoneNumber, sendSms: phoneNumber != '09132256785' && phoneNumber != '9132256785'),
      onResponse: (final GenericResponse<String> onResponse) {
        dismissLoading();
      },
      onError: (final GenericResponse<dynamic> onError) {
        dismissLoading();
        // snackbar(
        //   title: s.error,
        //   description: s.codeError,
        //   dialogMessage: DialogMessage.warning,
        // );
      },
    );
    counter.value = 59;
    startTimer();
  }
}
