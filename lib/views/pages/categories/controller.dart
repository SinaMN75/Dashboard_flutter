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

  RxString selectedCategoryUseCase=''.obs;
  List<String> listCategoryUseCase=<String>[];
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();
  late DataSource dataSource;
  List<CategoryReadDto> list = App.categories.where((final CategoryReadDto element) => element.useCase == "category").toList();

  void onEditTap({required final CategoryReadDto dto}) => push(CategoryDetailPage(category: dto));

  void onDeleteTap({required final CategoryReadDto dto}) => push(CategoryDetailPage(category: dto));

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document = gridKey.currentState!.exportToPdfDocument(
        cellExport: (final DataGridCellPdfExportDetails details) {
          if (details.cellType == DataGridExportCellType.row) {
            if (details.columnName == 'Shipped Date') {
              details.pdfCell.value = DateFormat('MM/dd/yyyy').format(DateTime.parse(details.pdfCell.value));
            }
          }
        },
        headerFooterExport: (final DataGridPdfHeaderFooterExportDetails details) {
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
  void addListCategoryUseCase(){
   const List<UseCaseCategory> listUsecaseCategory= UseCaseCategory.values;
   listUsecaseCategory.forEach((final UseCaseCategory element) {
      listCategoryUseCase.add(element.title);
    });
    selectedCategoryUseCase.value=UseCaseCategory.values.first.title;

    print(selectedCategoryUseCase.value);
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
}
