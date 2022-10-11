part of 'core.dart';

class AppConstants {
  static const String baseUrl = "https://api.sinamn75.com/api";
  static const String theme = "theme";
  static const String userId = "userId";
}

enum UseCaseCategory {
  insurance("insurance");

  const UseCaseCategory(this.title);

  @override
  String toString() => name;
  final String title;
}
enum UseCaseBime {
  bime("bime");

  const UseCaseBime(this.title);

  @override
  String toString() => name;
  final String title;
}
enum UseCaseSlider {
  sliderBime("sliderBime");

  const UseCaseSlider(this.title);

  @override
  String toString() => name;
  final String title;
}
enum UseCasePaymentBime {
  paymentBime("paymentBime");

  const UseCasePaymentBime(this.title);

  @override
  String toString() => name;
  final String title;
}
