import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/page.dart';
import 'package:utilities/utilities.dart';

mixin SplashController {
  final CategoryDataSource categoryDataSource = CategoryDataSource(baseUrl: AppConstants.baseUrl);

  void initApp() {
    categoryDataSource.read(
      onResponse: (final GenericResponse<CategoryReadDto> onResponse) {
        App.categories = onResponse.resultList ?? <CategoryReadDto>[];
        offAll(const CategoriesPage());
      },
      onError: (final GenericResponse<dynamic> onError) => snackbarRed(title: s.error, subtitle: onError.message),
    );
  }
}