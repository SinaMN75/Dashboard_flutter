import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/login/login_controller.dart';
import 'package:dashboard/views/widgets/form.dart';
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
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: context.theme.shadowColor,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                AppImages.backImage,
                repeat: ImageRepeat.repeat,
              ),
            ),
            Center(
              child: Container(
                width: 500,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.theme.backgroundColor,
                  boxShadow: const <BoxShadow>[
                    // BoxShadow(color: AppColorsDark.disabled,),
                    BoxShadow(offset: Offset(0, 1), blurRadius: 2),
                  ],
                ),
                child: Form(
                  key: formKeyLogin,
                  child: column(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: Get.width,
                    isScrollable: true,
                    children: <Widget>[
                      const SizedBox(height: 14),
                      Text(s.enterYourEmailAndPassword).headline1(fontSize: 24),
                      const SizedBox(height: 75),
                      textFormField(
                        label: s.email,
                        onChanged: (final String value) {},
                        controller: emailController,
                      ),
                      const SizedBox(height: 14),
                       textFormField(
                        label: s.password,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (final String value) {},
                        controller: passwordController,
                      ),

                      const SizedBox(height: 75),
                      button(
                        width: Get.width,
                        title: s.confirm,
                        textStyle: context.textTheme.headline5,
                        onTap: () => validateForm(key: formKeyLogin, action: onNextClick),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            // Center(
            //   child: Container(
            //     width: 600,
            //     height: 600,
            //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       color: context.theme.backgroundColor,
            //       boxShadow: const <BoxShadow>[
            //         // BoxShadow(color: AppColorsDark.disabled,),
            //         BoxShadow(offset: Offset(0, 1), blurRadius: 2),
            //       ],
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Form(
            //           key: formKeyLogin,
            //           child: textFormField(
            //             label: 'Enter your phon number',
            //             controller: phoneController,
            //           ),
            //           // child: TextFormField(
            //           //   validator: validatePhone(),
            //           //   controller: phoneController,
            //           //   textDirection: ui.TextDirection.ltr,
            //           //   maxLength: 11,
            //           //   keyboardType: TextInputType.number,
            //           //   inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
            //           //   decoration: InputDecoration(
            //           //     contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 34),
            //           //     hintStyle: context.textTheme.headline4!.copyWith(color: context.theme.hintColor),
            //           //     labelStyle: context.textTheme.headline4,
            //           //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            //           //     hintText: s.phoneNumber,
            //           //     hintTextDirection: ui.TextDirection.ltr,
            //           //     counterText: "",
            //           //   ),
            //           // ),
            //         ),
            //         const SizedBox(height: 75),
            //         button(
            //           width: Get.width,
            //           title: s.nextStep,
            //           textStyle: context.textTheme.headline5,
            //           onTap: () => validateForm(key: formKeyLogin, action: onNextClick),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      );
}
