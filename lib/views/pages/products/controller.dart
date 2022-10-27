import 'package:dashboard/common/save_file_mobile.dart' if (dart.library.html) 'package:dashboard/common/save_file_web.dart' as helper;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/category/categories/detail.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:utilities/utilities.dart';

mixin ProductsController {
  ProductV2DataSource productDataSource = ProductV2DataSource(baseUrl: AppConstants.baseUrl);
  RxString selectedProductUseCase = ''.obs;
  RxString selectedProductType = ''.obs;
  List<String> listProductUseCase = <String>[];
  List<String> listProductType = <String>[];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController stateTr1Controller = TextEditingController();
  final TextEditingController stateTr2Controller = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();
  late Rx<DataSource> dataSource = DataSource(<ProductReadDto>[]).obs;
  RxList<ProductReadDto> list = <ProductReadDto>[].obs;

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
      },
    );
    final List<int> bytes = document.saveSync();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
    document.dispose();
  }

  void addListProductUseCase() {
    const List<UseCaseProduct> tmpUseCases = UseCaseProduct.values;
    const List<TenderType> tmpTypes = TenderType.values;

    tmpUseCases.forEach((final UseCaseProduct element) {
      listProductUseCase.add(element.title);
    });
    selectedProductUseCase.value = UseCaseCategory.values.first.title;

    tmpTypes.forEach((final TenderType element) {
      listProductType.add(element.title);
    });
    selectedProductType.value = TenderType.values.first.title;
  }

  void createProduct() {
    print("C");
    productDataSource.create(
      dto: ProductCreateUpdateDto(
        title: titleController.text,
        subtitle: subTitleController.text,
        description: descriptionController.text,
        details: detailsController.text,
        address: addressController.text,
        author: authorController.text,
        phoneNumber: phoneNumberController.text,
        link: linkController.text,
        email: emailController.text,
        state: stateController.text,
        stateTr1: stateTr1Controller.text,
        price: double.parse(priceController.text),
        latitude: double.parse(latitudeController.text),
        longitude: double.parse(longitudeController.text),
        useCase: selectedProductUseCase.value,
        type: selectedProductType.value,
      ),
      onResponse: (final GenericResponse<ProductReadDto> response) {
        back();
      },
      onError: (final GenericResponse<dynamic> response) {},
    );
  }

  void getProducts({required final VoidCallback action}) {
    productDataSource.filter(
      filter: ProductFilterDto(),
      onResponse: (final GenericResponse<ProductReadDto> response) {
        list.value = response.resultList!;
        action();
      },
      onError: (final _) {},
    );
  }
}

class DataSource extends DataGridSource {
  DataSource(final List<ProductReadDto> list) {
    dataGridRow = list
        .mapIndexed<DataGridRow>(
          (final int index, final ProductReadDto e) => DataGridRow(
            cells: <DataGridCell>[
              DataGridCell<int>(columnName: index.toString(), value: index),
              DataGridCell<ProductReadDto>(columnName: e.id ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.title ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.subtitle ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.description ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.details ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.address ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.author ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.phoneNumber ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.link ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.email ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.state ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.stateTr1 ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.stateTr2 ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.latitude.toString(), value: e),
              DataGridCell<ProductReadDto>(columnName: e.longitude.toString(), value: e),
              DataGridCell<ProductReadDto>(columnName: e.price.toString(), value: e),
              DataGridCell<ProductReadDto>(columnName: e.useCase ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.type ?? "", value: e),
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
