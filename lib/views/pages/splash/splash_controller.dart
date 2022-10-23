import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/login/login_page.dart';
import 'package:dashboard/views/pages/main/main_page.dart';
import 'package:utilities/utilities.dart';

mixin SplashController {
  final CategoryDataSource categoryDataSource = CategoryDataSource(baseUrl: AppConstants.baseUrl);

  void initApp() {



    final bool loginStatus = getBool(AppConstants.userLogin) ?? false;
    //read category
    categoryDataSource.read(
      onResponse: (final GenericResponse<CategoryReadDto> onResponse) {
        App.categories = onResponse.resultList ?? <CategoryReadDto>[];
        delay(2000, () => loginStatus ? getUser() : offAll(const LoginPage()));
      },
      onError: (final GenericResponse<dynamic> onError) {
        snackBarError(onError.message);
      },
    );


  }


  void getUser(){
    categoryDataSource.read(
      onResponse: (final GenericResponse<CategoryReadDto> onResponse) {
        App.categories = onResponse.resultList ?? <CategoryReadDto>[];
        offAll(const MainPage());
      },
      onError: (final GenericResponse<dynamic> onError) => snackbarRed(title: s.error, subtitle: onError.message),
    );
  }
}
