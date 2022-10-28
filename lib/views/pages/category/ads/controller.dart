import 'package:dashboard/common/save_file_mobile.dart' if (dart.library.html) 'package:dashboard/common/save_file_web.dart' as helper;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/category/ads/detail.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:utilities/utilities.dart';

mixin AdsController {
  final Rx<PageState> state = PageState.initial.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  CategoryDataSource categoryDataSource = CategoryDataSource(baseUrl: AppConstants.baseUrl);
  MediaDataSource mediaDataSource = MediaDataSource(baseUrl: AppConstants.baseUrl);
  FormDataSource formDataSource = FormDataSource(baseUrl: AppConstants.baseUrl);
  List<FormReadDto> forms = <FormReadDto>[];
  List<String> listOfDeleteFile = <String>[];
  List<String> listOfDeleteImage = <String>[];
  List<PlatformFile> listOfNewFile = <PlatformFile>[];
  List<PlatformFile> listOfNewImage = <PlatformFile>[];

  String useCase = UseCaseCategory.ad.title;

  /// ********** CONTROLLER ***************/
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController titleTr1Controller = TextEditingController();
  TextEditingController titleTr2Controller = TextEditingController();
  TextEditingController linkController = TextEditingController();

  /// ********** OTHER ***************/

  Color pickerColor = Colors.blue;

  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();
  late DataSource dataSource;
  List<CategoryReadDto> list = <CategoryReadDto>[];

  // List<CategoryReadDto> list = App.categories.where((final CategoryReadDto element) => element.useCase == "category").toList();
  void initApp({required final VoidCallback action}) {
    //read category
    state.loading();
    showLoading();
    categoryDataSource.read(
      onResponse: (final GenericResponse<CategoryReadDto> onResponse) {
        list = onResponse.resultList
            .getByUseCase(
              useCase: useCase,
            );
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
    final String? res = await Get.to(AdsDetailPage(category: dto));
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

  void confirm({
    required final VoidCallback action,
  }) {
    final CategoryCreateUpdateDto filter = CategoryCreateUpdateDto(
      title: titleController.text,
      subtitle: subTitleController.text,
      titleTr1: titleTr1Controller.text,
      titleTr2: titleTr2Controller.text,
      link: linkController.text,
      useCase: useCase,
      color: stringToHexColor(pickerColor),
    );
    categoryDataSource.create(
      dto: filter,
      onResponse: (final GenericResponse<CategoryReadDto> response) async {
        if (listOfNewFile.isNotEmpty || listOfNewImage.isNotEmpty) {
          await addNewFiles(
            response.result?.id ?? '',
            action: () async {
              await addNewImage(response.result?.id ?? '', action: action);
            },
          );
        } else {
          action();
        }
      },
      onError: (final GenericResponse<dynamic> errorResponse) {},
    );
  }

  void updateCategory(final CategoryReadDto categoryReadDto, {required final VoidCallback action}) {
    final CategoryCreateUpdateDto filter = CategoryCreateUpdateDto(
      id: categoryReadDto.id,
      title: titleController.text,
      subtitle: subTitleController.text,
      titleTr1: titleTr1Controller.text,
      titleTr2: titleTr2Controller.text,
      link: linkController.text,
      useCase: useCase,
      color: stringToHexColor(pickerColor),
    );
    categoryDataSource.update(
      dto: filter,
      onResponse: (final GenericResponse<CategoryReadDto> response) async {
        await deleteOldFiles(
          response.result?.id ?? '',
          action: () async {
            await addNewFiles(
              response.result?.id ?? '',
              action: () async {
                await addNewImage(response.result?.id ?? '', action: action);
              },
            );
          },
        );
      },
      onError: (final GenericResponse<dynamic> errorResponse) {},
    );
  }

  Future<void> deleteOldFiles(final String catId, {required final VoidCallback action}) async {
    if (listOfDeleteFile.isNotEmpty) {
      int countDelete = 0;
      for (int i = 0; i < listOfDeleteFile.length; i++) {
        await mediaDataSource.delete(
          id: listOfDeleteFile[i],
          onResponse: (final GenericResponse<dynamic> response2) {
            if (countDelete == listOfDeleteFile.length - 1) {
              action();
            }
            countDelete++;
          },
          onError: (final GenericResponse<dynamic> errorResponse) {},
        );
      }
    } else {
      action();
    }
  }

  Future<void> addNewFiles(final String catId, {required final VoidCallback action}) async {
    if (listOfNewFile.isNotEmpty) {
      for (int i = 0; i < listOfNewFile.length; i++) {
        await mediaDataSource.createWebV2(
          useCase: UseCaseMedia.all.title,
          categoryId: catId,
          files: <PlatformFile>[
            ...<PlatformFile>[listOfNewFile[i]],
          ],
          action: action,
          error: (final int statusCode) {
            action();
          },
        );
      }
    } else {
      action();
    }
  }

  Future<void> addNewImage(final String catId, {required final VoidCallback action}) async {
    if (listOfNewImage.isNotEmpty) {
      for (int i = 0; i < listOfNewImage.length; i++) {
        await mediaDataSource.createWebV2(
          useCase: UseCaseMedia.image.title,
          categoryId: catId,
          files: <PlatformFile>[
            ...<PlatformFile>[listOfNewImage[i]],
          ],
          action: action,
          error: (final int statusCode) {
            action();
          },
        );
      }
    } else {
      action();
    }
  }

  Color hexToColor(final String code) => Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

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
              DataGridCell<CategoryReadDto>(columnName: e.title ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.subtitle ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.titleTr1 ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.titleTr2 ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.color ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.link ?? "", value: e),
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
