part of 'core.dart';

class AppConstants {
  static const String baseUrl = "https://api.sinamn75.com/api";
  static const String theme = "theme";
  static const String userId = "userId";
  static const String userLogin = "userLogin";
}

// enum UseCaseCategory {
//   insurance("insurance");
//
//   const UseCaseCategory(this.title);
//
//   @override
//   String toString() => name;
//   final String title;
// }

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


enum SortLists {
  atoZ("0"),
  zToA("1"),
  mostRecent("2"),
  oldest("3"),
  cheapest("4"),
  mostExpensive("5"),
  orderByVotes("6");

  const SortLists(this.title);

  @override
  String toString() => name;
  final String title;
}

enum Currency {
  rial("100"),
  dolor("101"),
  lira("102"),
  euro("103"),
  btc("200");

  const Currency(this.title);

  @override
  String toString() => name;
  final String title;
}

enum CreateProductStatus {
  inQueue(2),
  done(0);

  const CreateProductStatus(this.title);

  final int title;
}

enum UseCaseProduct {
  ad("ad"),
  dailyPrice("dailyPrice"),
  tender("tender"),
  project("project"),
  service("service"),
  consultant("consultant"),
  company("company"),
  tutorial("tutorial"),
  magazine("magazine");

  const UseCaseProduct(this.title);

  final String title;
}

enum UseCaseCategory {
  ad("ad"),
  dailyPrice("dailyPrice"),
  tender("tender"),
  auction("auction"),
  project("project"),
  service("service"),
  consultant("consultant"),
  company("company"),
  tutorial("tutorial"),
  magazine("magazine");

  const UseCaseCategory(this.title);

  @override
  String toString() => name;
  final String title;
}

enum UseCaseNotification {
  success("success"),
  error("error"),
  message("message");

  const UseCaseNotification(this.title);

  @override
  String toString() => name;
  final String title;
}

enum CategoryType {
  brand("brand"),
  reference("reference"),
  company("company"),
  category("category"),
  function("function"),
  country("country"),
  city("city"),
  province("province"),
  model("model"),
  speciality("speciality");

  const CategoryType(this.title);

  @override
  String toString() => name;
  final String title;
}

enum TenderType {
  tender("tender"),
  auction("auction");

  const TenderType(this.title);

  @override
  String toString() => name;
  final String title;
}

enum DialogMessage { info, warning, success }
