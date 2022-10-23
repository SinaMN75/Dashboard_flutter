import 'package:dashboard/common/save_file_mobile.dart' if (dart.library.html) 'package:dashboard/common/save_file_web.dart' as helper;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/detail.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:utilities/utilities.dart';

mixin CategoriesController {
  final Rx<PageState> state = PageState.initial.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  CategoryDataSource categoryDataSource = CategoryDataSource(baseUrl: AppConstants.baseUrl);
  MediaDataSource mediaDataSource = MediaDataSource(baseUrl: AppConstants.baseUrl);
  FormDataSource formDataSource = FormDataSource(baseUrl: AppConstants.baseUrl);
  List<FormReadDto> forms = <FormReadDto>[];

  /// ********** CONTROLLER ***************/
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  /// ********** OTHER ***************/

  Color pickerColor = Colors.blue;
  List<PlatformFile> imagess = <PlatformFile>[];
  List<PlatformFile> filess = <PlatformFile>[];

  List<String> listCategoryUseCase = <String>[];
  RxString selectedCategoryUseCase = ''.obs;
  List<String> listCategoryType = <String>[];
  RxString selectedCategoryType = ''.obs;
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();
  late DataSource dataSource;
  List<CategoryReadDto> list = App.categories;

  // List<CategoryReadDto> list = App.categories.where((final CategoryReadDto element) => element.useCase == "category").toList();
  void initApp({required final VoidCallback action}) {
    //read category
    state.loading();
    showLoading();
    categoryDataSource.read(
      onResponse: (final GenericResponse<CategoryReadDto> onResponse) {
        App.categories = onResponse.resultList ?? <CategoryReadDto>[];
        list = App.categories;
        dataSource = DataSource(list);
        state.loaded();
        dismissLoading();
        action();
      },
      onError: (final GenericResponse<dynamic> onError) {
        snackBarError(onError.message);
        dismissLoading();
        state.loaded();
      },
    );
  }

  // void onEditTap({required final CategoryReadDto dto}) => push(CategoryDetailPage(category: dto));
  void onEditTap({required final CategoryReadDto dto, required final VoidCallback action}) async {
    final String? res = await Get.to( CategoryDetailPage(category: dto));
    if (res == BackResult.ok.title) {
      initApp(action: action);
    }
  }

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document = gridKey.currentState!.exportToPdfDocument(cellExport: (final DataGridCellPdfExportDetails details) {
      if (details.cellType == DataGridExportCellType.row) {
        if (details.columnName == 'Shipped Date') {
          details.pdfCell.value = DateFormat('MM/dd/yyyy').format(DateTime.parse(details.pdfCell.value));
        }
      }
    }, headerFooterExport: (final DataGridPdfHeaderFooterExportDetails details) {
      final double width = details.pdfPage.getClientSize().width;
      final PdfPageTemplateElement header = PdfPageTemplateElement(Rect.fromLTWH(0, 0, width, 65));
      header.graphics.drawString(
        'Product Details',
        PdfStandardFont(PdfFontFamily.helvetica, 13, style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(0, 25, 200, 60),
      );

      details.pdfDocumentTemplate.top = header;
    });
    final List<int> bytes = document.saveSync();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
    document.dispose();
  }

  void addListCategoryUseCase() {
    const List<UseCaseCategory> listUsecaseCategory = UseCaseCategory.values;
    listUsecaseCategory.forEach((final UseCaseCategory element) {
      listCategoryUseCase.add(element.title);
    });
    selectedCategoryUseCase.value = UseCaseCategory.values.first.title;

  }

  void addListCategoryType() {
    const List<CategoryType> listTypeCategory = CategoryType.values;
    listTypeCategory.forEach((final CategoryType element) {
      listCategoryType.add(element.title);
    });
    selectedCategoryType.value = CategoryType.values.first.title;

  }

  void updateCategory(final CategoryReadDto categoryReadDto, {required final VoidCallback action}) {
    final CategoryCreateUpdateDto filter = CategoryCreateUpdateDto(
      id: categoryReadDto.id,
      title: titleController.text,
      subtitle: subTitleController.text,
      useCase: selectedCategoryUseCase.value,
      type: selectedCategoryType.value,
      color: stringToHexColor(pickerColor),

    );
    categoryDataSource.update(
        dto: filter,
        onResponse: (final GenericResponse<CategoryReadDto> response) async {
          if (imagess.isNotEmpty) {
            await mediaDataSource.createWebV2(
              useCase: "media",
              productId: response.result!.id,
              files: <PlatformFile>[
                ...imagess,
                ...filess,
              ],
              action: action,
              error: (final int statusCode) {
                action();
              },
            );
          } else {
            action();
          }
        },
        onError: (final GenericResponse<dynamic> errorResponse) {
        });
  }

  void confirm({required final VoidCallback action}) {
    final CategoryCreateUpdateDto filter = CategoryCreateUpdateDto(
      title: titleController.text,
      subtitle: subTitleController.text,
      useCase: selectedCategoryUseCase.value,
      type: selectedCategoryType.value,
    );
    categoryDataSource.create(
      dto: filter,
      onResponse: (final GenericResponse<CategoryReadDto> response) async {
        if (imagess.isNotEmpty || filess.isNotEmpty) {
          await mediaDataSource.createWebV2(
            useCase: "media",
            productId: response.result!.id,
            files: <PlatformFile>[
              ...imagess,
              ...filess,
            ],
            action: action,
            error: (final int statusCode) {
              action();
            },
          );
        } else {
          action();
        }
      },
      onError: (final GenericResponse<dynamic> errorResponse) {
      },
    );
  }

  Color hexToColor(final String code) =>  Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

  void deleteCategory({required final CategoryReadDto category, required final VoidCallback action}) {
    categoryDataSource.delete(
      id: category.id ?? "",
      onResponse: (final GenericResponse<dynamic> response) {
        initApp(action: action);

      },
      onError: (final GenericResponse<dynamic> errorResponse) {
        initApp(action: action);
      },
    );
  }
}

class DataSource extends DataGridSource {
  DataSource(final List<CategoryReadDto> list) {
    dataGridRow = list
        .mapIndexed<DataGridRow>(
          (final int index, final CategoryReadDto e) => DataGridRow(
            cells: <DataGridCell>[
              DataGridCell<int>(columnName: index.toString(), value: index),
              DataGridCell<CategoryReadDto>(columnName: e.id ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.title ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.titleTr1 ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.titleTr2 ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.subtitle ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.color ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.link ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.parent?.title ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.useCase ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.type ?? "", value: e),
            ],
          ),
        )
        .toList();
  }

  late List<DataGridRow> dataGridRow;

  @override
  List<DataGridRow> get rows => dataGridRow;

  @override
  DataGridRowAdapter? buildRow(final DataGridRow row) => DataGridRowAdapter(
        cells: row
            .getCells()
            .map<Widget>(
              (final DataGridCell e) => gridRow(e.columnName),
            )
            .toList(),
      );

  @override
  int compare(final DataGridRow? a, final DataGridRow? b, final SortColumnDetails sortColumn) {
    final String? value1 = a?.getCells().firstWhereOrNull((final DataGridCell element) => element.columnName == sortColumn.name)?.value;
    final String? value2 = b?.getCells().firstWhereOrNull((final DataGridCell element) => element.columnName == sortColumn.name)?.value;

    final int? aLength = value1?.length;
    final int? bLength = value2?.length;

    if (aLength == null || bLength == null) {
      return 0;
    }

    if (aLength.compareTo(bLength) > 0) {
      return sortColumn.sortDirection == DataGridSortDirection.ascending ? 1 : -1;
    } else if (aLength.compareTo(bLength) == -1) {
      return sortColumn.sortDirection == DataGridSortDirection.descending ? -1 : 1;
    } else {
      return 0;
    }
  }
}

// class EmployeeDataSource extends DataGridSource {
//   EmployeeDataSource({required final List<CategoryReadDto> employees}) {
//     dataGridRows = employees
//         .mapIndexed<DataGridRow>((final int index,final CategoryReadDto dataGridRow) => DataGridRow(cells: <DataGridCell>[
//       DataGridCell<int>(columnName: index.toString(), value: index),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.id ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.title ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.titleTr1 ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.titleTr2 ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.subtitle ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.color ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.link ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.parent?.title ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.useCase ?? "", value: dataGridRow),
//       DataGridCell<CategoryReadDto>(columnName: dataGridRow.type ?? "", value: dataGridRow),
//     ]))
//         .toList();
//   }
//
//   List<DataGridRow> dataGridRows = [];
//
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//           return Container(
//               alignment: (dataGridCell.columnName == 'id' ||
//                   dataGridCell.columnName == 'salary')
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 dataGridCell.value.toString(),
//                 overflow: TextOverflow.ellipsis,
//               ));
//         }).toList());
//   }
//
//   @override
//   int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
//     final String? value1 = a
//         ?.getCells()
//         .firstWhereOrNull((element) => element.columnName == sortColumn.name)
//         ?.value;
//     final String? value2 = b
//         ?.getCells()
//         .firstWhereOrNull((element) => element.columnName == sortColumn.name)
//         ?.value;
//
//     int? aLength = value1?.length;
//     int? bLength = value2?.length;
//
//     if (aLength == null || bLength == null) {
//       return 0;
//     }
//
//     if (aLength.compareTo(bLength) > 0) {
//       return sortColumn.sortDirection == DataGridSortDirection.ascending
//           ? 1
//           : -1;
//     } else if (aLength.compareTo(bLength) == -1) {
//       return sortColumn.sortDirection == DataGridSortDirection.ascending
//           ? -1
//           : 1;
//     } else {
//       return 0;
//     }
//   }
// }
