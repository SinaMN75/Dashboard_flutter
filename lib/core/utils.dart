part of 'core.dart';

S s = S.of(context);

FormFieldValidator<String> validateEmail() => (final String? value) {
      if (value!.isEmpty) return s.thisFieldIsRequired;
      if (!value.isEmail) return s.incorrectEmailFormat;
      return null;
    };

FormFieldValidator<String> validateNumber() => (final String? value) {
      // if (value!.isEmpty) return "* این فیلد الزامی است";
      if (value!.isEmpty) return s.thisFieldIsRequired;
      // if (!value.isNumericOnly) return "* فرمت شماره موبایل صحیح نیست";
      if (!value.isNumericOnly) return s.incorrectMobilePhoneNumberFormat;
      return null;
    };

String dateShamsi(final String date) => Jalali.fromDateTime(DateTime.parse(date)).toString().replaceAll("-", "/");


void snackBarError(final String message, {final String? title}) => Get.snackbar(
  title ?? s.warning,
  message,
  backgroundColor: AppColors.error,
  colorText: Colors.white,
);

FormFieldValidator<String> validateNotEmpty() => (final String? value) {
      if (value!.isEmpty) return s.thisFieldIsRequired;
      else  return null;
    };

void dismissKeyboard()=>FocusManager.instance.primaryFocus?.unfocus();

void showLoading() {
  dialog(
    Container(
      width: Get.width,
      height: Get.height,
      color: context.theme.primaryColorDark.withOpacity(0.1),
      child: const Center(child: CircularProgressIndicator()),
    ),
  );
  delay(10000, dismissLoading);
}
void dismissLoading() {
  if (Get.isDialogOpen ?? false) back();
}
bool isPersianLang() => Get.locale == const Locale("fa");
void snackbar({
  required final DialogMessage dialogMessage,
  final String title = "",
  final String description = "",
}) =>
    Get.snackbar(
      title,
      description,
      colorText: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      backgroundColor: dialogMessage == DialogMessage.warning
          ? const Color(0xFFFEF7EA)
          : dialogMessage == DialogMessage.info
          ? const Color(0xFFE6EFFA)
          : const Color(0xFFEAF7EE),
      borderWidth: 1,
      borderColor: dialogMessage == DialogMessage.warning
          ? const Color(0xFFECD8A0)
          : dialogMessage == DialogMessage.info
          ? const Color(0xFF80B3EE)
          : const Color(0xFF8FE598),
      icon: image(
        dialogMessage == DialogMessage.warning
            ? AppIcons.warning
            : dialogMessage == DialogMessage.info
            ? AppIcons.info
            : AppIcons.success,
        margin: EdgeInsets.only(right: isPersianLang() ? 8 : 0, left: isPersianLang() ? 0 : 8),
      ),
    );

FormFieldValidator<String> validatePassword() => (final String? value) {
      if (value!.isEmpty)
        return s.thisFieldIsRequired;
      else if (value.length < 4)
        return s.incorrectPassword;
      else
        return null;
    };

FormFieldValidator<String> validatePhone() => (final String? value) {
  if (value!.isEmpty) return s.thisFieldIsRequired;
  if (!isPhoneNumber(value)) return s.incorrectMobilePhoneNumberFormat;
  return null;
};


/// Checks if string is phone number.
bool isPhoneNumber(final String s) {
  if (s.length > 16 || s.length < 9) return false;
  return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
}

bool hasMatch(final String? value, final String pattern) => (value == null) ? false : RegExp(pattern).hasMatch(value);

FormFieldValidator<String> validateUserName() => (final String? value) {
      final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
      if (value!.isEmpty)
        return s.thisFieldIsRequired;
      else if (!alphanumeric.hasMatch(value))
        return s.incorrectUsername;
      else
        return null;
    };

FormFieldValidator<String> validateFirstName() => (final String? value) {
      if (value!.isEmpty)
        return s.thisFieldIsRequired;
      else if (value.length < 3)
        return s.incorrectUsername;
      else
        return null;
    };

FormFieldValidator<String> validateLastName() => (final String? value) {
      if (value!.isEmpty)
        return s.thisFieldIsRequired;
      else if (value.length < 3)
        return s.incorrectUsername;
      else
        return null;
    };

FormFieldValidator<String> validateJobName() => (final String? value) {
      if (value!.isEmpty)
        return s.thisFieldIsRequired;
      else if (value.length < 3)
        return s.incorrectUsername;
      else
        return null;
    };

void appBottomSheet({required final Widget child, final double height = 300}) => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      builder: (final BuildContext context) => Container(
        margin: MediaQuery.of(context).viewInsets,
        height: height,
        decoration: BoxDecoration(
          color: context.theme.backgroundColor.withOpacity(0.9),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );

bool isRTL() => Directionality.of(context).toString().contains(TextDirection.RTL.value.toLowerCase());
