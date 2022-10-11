import 'package:dashboard/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';
import 'package:utilities/utils/shamsi_date/shamsi_date.dart';

part 'constants.dart';

part 'theme.dart';

part 'utils.dart';

class App {
  static String appVersion = "1.0.0";
  static UserReadDto userReadDto = UserReadDto();
  static List<CategoryReadDto> categories = <CategoryReadDto>[];
  static List<ContentReadDto> contents = <ContentReadDto>[];
  static List<ContentReadDto> sliders = <ContentReadDto>[];
  static List<ContentReadDto> paymentLink = <ContentReadDto>[];

  static List<IranLocationReadDto> locations = <IranLocationReadDto>[];
}
