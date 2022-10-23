import 'dart:ui' as ui;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/otp/otp_controller.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({required this.mobile,final Key? key}) : super(key: key);
  final String mobile;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with OtpController {
  @override
  void initState() {
    phoneNumber = widget.mobile;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => scaffold(
    constraints: const BoxConstraints(maxWidth: 500),
    alignment: Alignment.center,
    resizeToAvoidBottomInset: true,
    body: Center(
      child: column(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: Get.width,
        isScrollable: true,
        children: <Widget>[
          Text(s.enterVerificationCode).headline3(color: context.theme.primaryColorDark),
          const SizedBox(height: 14),
          Text('${s.codeSentToNumber} ${widget.mobile}' ).button(color: context.theme.dividerColor),
          const SizedBox(height: 75),
          Directionality(
            textDirection: ui.TextDirection.ltr,
            child: PinCodeTextField(
              appContext: context,
              length: 4,
              autoFocus: true,
              animationType: AnimationType.fade,
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: context.textTheme.headline1,
              hintCharacter: "*",
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldOuterPadding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                borderRadius: BorderRadius.circular(14),
                fieldHeight: 64,
                fieldWidth: 60,
                activeFillColor: context.theme.backgroundColor,
                inactiveFillColor: context.theme.backgroundColor,
                selectedFillColor: context.theme.backgroundColor,
                inactiveColor: context.theme.dividerColor,
                selectedColor: context.theme.dividerColor,
                activeColor: context.theme.dividerColor,
              ),
              cursorColor: context.theme.primaryColorDark,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              onCompleted: (final String pin) {
                pinValue = pin;
                onConfirmationClick();
              },
              onChanged: (final String value) {},
            ),
          ),
          const SizedBox(height: 75),
          button(
            width: Get.width,
            title: s.submit,
            textStyle: context.textTheme.headline5,
            onTap: onConfirmationClick,
          ),
          const SizedBox(height: 30),
          Obx(
                () => counter.value == 0
                ? TextButton(onPressed: onResendCode, child: Text(s.resendCode).button(color: context.theme.primaryColor))
                : isPersianLang()
                ? RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: !isPersianLang() ? s.secondsToSendAgain : "",
                    style: context.textTheme.button!.copyWith(color: context.theme.dividerColor),
                  ),
                  TextSpan(
                    text: " ${counter.value.toString()} ",
                    style: context.textTheme.button!.copyWith(color: context.theme.primaryColor),
                  ),
                  TextSpan(
                    text: isPersianLang() ? s.secondsToSendAgain : "",
                    style: context.textTheme.button!.copyWith(color: context.theme.dividerColor),
                  ),
                ],
              ),
            )
                : RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: s.resendCodeIn,
                    style: context.textTheme.button!.copyWith(color: context.theme.dividerColor),
                  ),
                  TextSpan(
                    text: " ${counter.value.toString()} ",
                    style: context.textTheme.button!.copyWith(color: context.theme.primaryColor),
                  ),
                  TextSpan(
                    text: s.seconds,
                    style: context.textTheme.button!.copyWith(color: context.theme.dividerColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: GestureDetector(
      onTap: onEditPhoneNumberClick,
      child: SizedBox(
        width: Get.width,
        height: 60,
        child: Text(
          s.changePhoneNumber,
          textAlign: TextAlign.center,
        ).button(color: context.theme.dividerColor).marginOnly(bottom: 32),
      ),
    ),
  );
}
