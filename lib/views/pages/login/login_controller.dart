import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

mixin LoginController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  final UserDataSource userDataSource = UserDataSource(baseUrl: AppConstants.baseUrl);
  void onNextClick() {
    showLoading();
    userDataSource.loginWithPassword(
      dto: LoginWithPassword(email: emailController.text, password: passwordController.text ),
      onResponse: (final GenericResponse<UserReadDto> onResponse) {
        setData(UtilitiesConstants.token, "Bearer ${onResponse.result?.token}");
        setData(AppConstants.userId, onResponse.result?.id);
        App.userReadDto = onResponse.result;
        dismissLoading();
        setData(AppConstants.userLogin, true);
        offAll(const MainPage());
      },
      onError: (final GenericResponse<dynamic> onError) {
        dismissLoading();
        snackbar(dialogMessage: DialogMessage.warning, title: s.error, description: onError.message);
      },
      failure: () {
        dismissLoading();
        snackbar(dialogMessage: DialogMessage.warning, title: s.error, description: s.mistakeYourEmailOrPassword);
      },



    );
  }

}
