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

FormFieldValidator<String> validateNotEmpty() => (final String? value) {
      if (value!.isEmpty) return s.thisFieldIsRequired;
      else  return null;
    };

void dismissKeyboard()=>FocusManager.instance.primaryFocus?.unfocus();

FormFieldValidator<String> validatePassword() => (final String? value) {
      if (value!.isEmpty)
        return s.thisFieldIsRequired;
      else if (value.length < 4)
        return s.incorrectPassword;
      else
        return null;
    };

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
