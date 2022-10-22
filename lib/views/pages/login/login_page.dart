import 'dart:ui' as ui;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/login/login_controller.dart';
import 'package:dashboard/views/pages/splash/splash_controller.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utilities/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({final Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginController {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Column(
    children:  <Widget>[
      Form(
        key: formKeyLogin,
        child: TextFormField(
          validator: validatePhone(),
          controller: phoneController,
          textDirection: ui.TextDirection.ltr,
          maxLength: 11,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 34),
            hintStyle: context.textTheme.headline4!.copyWith(color: context.theme.hintColor),
            labelStyle: context.textTheme.headline4,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            hintText: s.phoneNumber,
            hintTextDirection: ui.TextDirection.ltr,
            counterText: "",
          ),
        ),
      ),
      const SizedBox(height: 75),
      button(
        width: Get.width,
        backgroundColor: context.theme.primaryColor,
        title: s.nextStep,
        onTap: () => validateForm(key: formKeyLogin, action: onNextClick),
      ),

    ],
  );
}
