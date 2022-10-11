

// extension NullableCategoryExtension on List<CategoryReadDto>? {
//   List<CategoryReadDto>? getByType(final CategoryType type) => this
//       ?.where(
//         (final CategoryReadDto e) => e.type == type.title,
//       )
//       .toList();
//
//   List<CategoryReadDto>? getByUseCase(final UseCaseCategory useCase) => this
//       ?.where(
//         (final CategoryReadDto e) => e.useCase == useCase.title,
//       )
//       .toList();
//
//   String getCategory() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.category.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getSubCategory() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.category.title)
//           .map(
//             (final CategoryReadDto e) => e.children!.getFirstIfExist()?.title,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getModel() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.model.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getFunction() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.function.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getBrand() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.brand.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   List<CategoryReadDto> getBrands({required final String useCase}) =>
//       this
//           ?.where(
//             (final CategoryReadDto e) => e.type == CategoryType.brand.title && e.useCase == useCase,
//           )
//           .map(
//             (final CategoryReadDto e) => e,
//           )
//           .toList() ??
//       <CategoryReadDto>[];
//
//   String getReference() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.reference.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getCountry() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.country.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getCity() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.city.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
//
//   String getProvince() =>
//       this
//           ?.where((final CategoryReadDto e) => e.type == CategoryType.province.title)
//           .map(
//             (final CategoryReadDto e) => e.title!,
//           )
//           .toList()
//           .getFirstIfExist() ??
//       "--";
// }
