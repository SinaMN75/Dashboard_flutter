// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Number is incorrect`
  String get numberIsIncorrect {
    return Intl.message(
      'Number is incorrect',
      name: 'numberIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect mobile phone number format`
  String get incorrectMobilePhoneNumberFormat {
    return Intl.message(
      'Incorrect mobile phone number format',
      name: 'incorrectMobilePhoneNumberFormat',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email format`
  String get incorrectEmailFormat {
    return Intl.message(
      'Incorrect email format',
      name: 'incorrectEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username`
  String get incorrectUsername {
    return Intl.message(
      'Incorrect username',
      name: 'incorrectUsername',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrectPassword {
    return Intl.message(
      'Incorrect password',
      name: 'incorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get post {
    return Intl.message(
      'Products',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Inactive Users`
  String get inactiveUsers {
    return Intl.message(
      'Inactive Users',
      name: 'inactiveUsers',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Id`
  String get id {
    return Intl.message(
      'Id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `TitleTr1`
  String get titleTr1 {
    return Intl.message(
      'TitleTr1',
      name: 'titleTr1',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Next step`
  String get nextStep {
    return Intl.message(
      'Next step',
      name: 'nextStep',
      desc: '',
      args: [],
    );
  }

  /// `Code error`
  String get codeError {
    return Intl.message(
      'Code error',
      name: 'codeError',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resendCode {
    return Intl.message(
      'Resend code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Seconds to send again`
  String get secondsToSendAgain {
    return Intl.message(
      'Seconds to send again',
      name: 'secondsToSendAgain',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in`
  String get resendCodeIn {
    return Intl.message(
      'Resend code in',
      name: 'resendCodeIn',
      desc: '',
      args: [],
    );
  }

  /// `picture`
  String get picture {
    return Intl.message(
      'picture',
      name: 'picture',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Pick a color!`
  String get pickColor {
    return Intl.message(
      'Pick a color!',
      name: 'pickColor',
      desc: '',
      args: [],
    );
  }

  /// `Upload photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Change phone number`
  String get changePhoneNumber {
    return Intl.message(
      'Change phone number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter verification code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to number`
  String get codeSentToNumber {
    return Intl.message(
      'Code sent to number',
      name: 'codeSentToNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter four digit pin`
  String get pleaseEnterFourDigitPin {
    return Intl.message(
      'Please enter four digit pin',
      name: 'pleaseEnterFourDigitPin',
      desc: '',
      args: [],
    );
  }

  /// `TitleTr2`
  String get titleTr2 {
    return Intl.message(
      'TitleTr2',
      name: 'titleTr2',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Create category`
  String get createCategory {
    return Intl.message(
      'Create category',
      name: 'createCategory',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Update category`
  String get updateCategory {
    return Intl.message(
      'Update category',
      name: 'updateCategory',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Subtitle`
  String get subtitle {
    return Intl.message(
      'Subtitle',
      name: 'subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `Parent`
  String get parent {
    return Intl.message(
      'Parent',
      name: 'parent',
      desc: '',
      args: [],
    );
  }

  /// `UseCase`
  String get usecase {
    return Intl.message(
      'UseCase',
      name: 'usecase',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `App email`
  String get appEmail {
    return Intl.message(
      'App email',
      name: 'appEmail',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get userName {
    return Intl.message(
      'User name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Create tenders`
  String get createTenders {
    return Intl.message(
      'Create tenders',
      name: 'createTenders',
      desc: '',
      args: [],
    );
  }

  /// `Update tenders`
  String get updateTenders {
    return Intl.message(
      'Update tenders',
      name: 'updateTenders',
      desc: '',
      args: [],
    );
  }

  /// `Ads`
  String get ads {
    return Intl.message(
      'Ads',
      name: 'ads',
      desc: '',
      args: [],
    );
  }

  /// `Create ads`
  String get createAds {
    return Intl.message(
      'Create ads',
      name: 'createAds',
      desc: '',
      args: [],
    );
  }

  /// `Update ads`
  String get updateAds {
    return Intl.message(
      'Update ads',
      name: 'updateAds',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get jobs {
    return Intl.message(
      'Jobs',
      name: 'jobs',
      desc: '',
      args: [],
    );
  }

  /// `Create jobs`
  String get createJobs {
    return Intl.message(
      'Create jobs',
      name: 'createJobs',
      desc: '',
      args: [],
    );
  }

  /// `Update jobs`
  String get updateJobs {
    return Intl.message(
      'Update jobs',
      name: 'updateJobs',
      desc: '',
      args: [],
    );
  }

  /// `Magazine`
  String get magazine {
    return Intl.message(
      'Magazine',
      name: 'magazine',
      desc: '',
      args: [],
    );
  }

  /// `Create magazine`
  String get createMagazine {
    return Intl.message(
      'Create magazine',
      name: 'createMagazine',
      desc: '',
      args: [],
    );
  }

  /// `Update magazine`
  String get updateMagazine {
    return Intl.message(
      'Update magazine',
      name: 'updateMagazine',
      desc: '',
      args: [],
    );
  }

  /// `Learn`
  String get learn {
    return Intl.message(
      'Learn',
      name: 'learn',
      desc: '',
      args: [],
    );
  }

  /// `Create learn`
  String get createLearn {
    return Intl.message(
      'Create learn',
      name: 'createLearn',
      desc: '',
      args: [],
    );
  }

  /// `Update learn`
  String get updateLearn {
    return Intl.message(
      'Update learn',
      name: 'updateLearn',
      desc: '',
      args: [],
    );
  }

  /// `Daily price`
  String get dailyPrice {
    return Intl.message(
      'Daily price',
      name: 'dailyPrice',
      desc: '',
      args: [],
    );
  }

  /// `Create Daily price`
  String get createDailyPrice {
    return Intl.message(
      'Create Daily price',
      name: 'createDailyPrice',
      desc: '',
      args: [],
    );
  }

  /// `Update Daily price`
  String get updateDailyPrice {
    return Intl.message(
      'Update Daily price',
      name: 'updateDailyPrice',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get projects {
    return Intl.message(
      'Projects',
      name: 'projects',
      desc: '',
      args: [],
    );
  }

  /// `Create projects`
  String get createProjects {
    return Intl.message(
      'Create projects',
      name: 'createProjects',
      desc: '',
      args: [],
    );
  }

  /// `Update projects`
  String get updateProjects {
    return Intl.message(
      'Update projects',
      name: 'updateProjects',
      desc: '',
      args: [],
    );
  }

  /// `Tenders`
  String get tenders {
    return Intl.message(
      'Tenders',
      name: 'tenders',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureToExitFromYourAccount {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureToExitFromYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `bio`
  String get bio {
    return Intl.message(
      'bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Point`
  String get point {
    return Intl.message(
      'Point',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and password`
  String get enterYourEmailAndPassword {
    return Intl.message(
      'Enter your email and password',
      name: 'enterYourEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Mistake your email or password`
  String get mistakeYourEmailOrPassword {
    return Intl.message(
      'Mistake your email or password',
      name: 'mistakeYourEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Create at`
  String get createAt {
    return Intl.message(
      'Create at',
      name: 'createAt',
      desc: '',
      args: [],
    );
  }

  /// `Select color`
  String get selectColor {
    return Intl.message(
      'Select color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Select image`
  String get selectImage {
    return Intl.message(
      'Select image',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Select file`
  String get selectFile {
    return Intl.message(
      'Select file',
      name: 'selectFile',
      desc: '',
      args: [],
    );
  }

  /// `Create user`
  String get createUser {
    return Intl.message(
      'Create user',
      name: 'createUser',
      desc: '',
      args: [],
    );
  }

  /// `Update user`
  String get updateUser {
    return Intl.message(
      'Update user',
      name: 'updateUser',
      desc: '',
      args: [],
    );
  }

  /// `Update at`
  String get updateAt {
    return Intl.message(
      'Update at',
      name: 'updateAt',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `This field required`
  String get thisFieldRequired {
    return Intl.message(
      'This field required',
      name: 'thisFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is incorrect`
  String get emailIsIncorrect {
    return Intl.message(
      'Email is incorrect',
      name: 'emailIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
