import 'package:dashboard/common/save_file_mobile.dart' if (dart.library.html) 'package:dashboard/common/save_file_web.dart' as helper;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:utilities/utilities.dart';

mixin TendersProductController {
  ProductV2DataSource productDataSource = ProductV2DataSource(baseUrl: AppConstants.baseUrl);
  CategoryDataSource categoryDataSource = CategoryDataSource(baseUrl: AppConstants.baseUrl);
  MediaDataSource mediaDataSource = MediaDataSource(baseUrl: AppConstants.baseUrl);

  List<String> listProductUseCase = <String>[];
  List<String> listProductType = <String>[];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();
  late Rx<DataSource> dataSource = DataSource(<ProductReadDto>[]).obs;
  RxList<ProductReadDto> list = <ProductReadDto>[].obs;
  RxList<CategoryReadDto> categorise = <CategoryReadDto>[].obs;
  Rx<CategoryReadDto> selectedCategory = CategoryReadDto().obs;
  List<PlatformFile> listOfNewImage = <PlatformFile>[];
  List<String> listOfDeleteFile = <String>[];

  void getCategorise() {
    categoryDataSource.read(
      onResponse: (final GenericResponse<CategoryReadDto> response) {
        categorise.value = response.resultList!.getByUseCase(useCase: UseCaseCategory.tender.title);
        if(categorise.isNotEmpty) selectedCategory.value = categorise.first;
      },
      onError: (final GenericResponse<dynamic> onError) {
        snackBarError(onError.message);
      },
    );
  }

  void deleteProduct({required final String id, required final VoidCallback action}) {
    productDataSource.delete(
      id: id,
      onResponse: (final _) => action(),
      onError: (final GenericResponse<dynamic> response) {
        print(response.message);
      },
    );
  }

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

  Future<void> addNewImage(final String productId, {required final VoidCallback action}) async {
    if (listOfNewImage.isNotEmpty) {
      for (int i = 0; i < listOfNewImage.length; i++) {
        await mediaDataSource.createWebV2(
          useCase: UseCaseMedia.image.title,
          productId: productId,
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

  void createProduct({final String? catId, final String? type, final VoidCallback? action}) {
    productDataSource.create(
      dto: ProductCreateUpdateDto(
        title: titleController.text,
        subtitle: subTitleController.text,
        description: descriptionController.text,
        address: addressController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        state: stateController.text,
        price: priceController.text.isEmpty ? null : double.parse(priceController.text),
        useCase: UseCaseProduct.tender.title,
        latitude: latitudeController.text.isEmpty ? null : double.parse(latitudeController.text),
        longitude: longitudeController.text.isEmpty ? null : double.parse(longitudeController.text),
        type: type,
        categories: catId == null ? null : <String>[catId],
      ),
      onResponse: (final GenericResponse<ProductReadDto> response) {
        addNewImage(response.result?.id ?? "", action: () {});
        action?.call();
      },
      onError: (final GenericResponse<dynamic> response) {},
    );
  }

  void editProduct({
    required final String id,
    final String? catId,
    final String? type,
    final VoidCallback? action,
  }) {
    productDataSource.update(
      dto: ProductCreateUpdateDto(
        id: id,
        title: titleController.text,
        subtitle: subTitleController.text,
        description: descriptionController.text,
        address: addressController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        state: stateController.text,
        price: priceController.text.isEmpty ? null : double.parse(priceController.text),
        useCase: UseCaseProduct.tender.title,
        latitude: latitudeController.text.isEmpty ? null : double.parse(latitudeController.text),
        longitude: longitudeController.text.isEmpty ? null : double.parse(longitudeController.text),
        type: type,
        categories: catId == null ? null : <String>[catId],
      ),
      onResponse: (final GenericResponse<ProductReadDto> response) {
        action?.call();
      },
      onError: (final GenericResponse<dynamic> response) {},
    );
  }

  void getProducts({required final VoidCallback action}) {
    productDataSource.filter(
      filter: ProductFilterDto(useCase: UseCaseProduct.tender.title),
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
              DataGridCell<ProductReadDto>(columnName: e.title ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.description ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.address ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.phoneNumber ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.email ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.state ?? "", value: e),
              DataGridCell<ProductReadDto>(columnName: e.latitude.toString(), value: e),
              DataGridCell<ProductReadDto>(columnName: e.longitude.toString(), value: e),
              DataGridCell<ProductReadDto>(columnName: e.price.toString(), value: e),
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
