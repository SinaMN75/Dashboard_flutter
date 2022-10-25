import 'package:dashboard/common/save_file_mobile.dart' if (dart.library.html) 'package:dashboard/common/save_file_web.dart' as helper;
import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/user/detail.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:utilities/utilities.dart';

mixin UserController {
  final Rx<PageState> state = PageState.initial.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  UserDataSource userDataSource = UserDataSource(baseUrl: AppConstants.baseUrl);
  MediaDataSource mediaDataSource = MediaDataSource(baseUrl: AppConstants.baseUrl);
  FormDataSource formDataSource = FormDataSource(baseUrl: AppConstants.baseUrl);
  List<FormReadDto> forms = <FormReadDto>[];
  List<String> listOfDeleteFile = <String>[];
  List<PlatformFile> listOfNewFiles = <PlatformFile>[];
  List<String> listOfNewUseCase = <String>[];
  List<UseCaseMedia> useCaseMedia2 = <UseCaseMedia>[];

  /// ********** CONTROLLER ***************/
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController appEmailController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  /// ********** OTHER ***************/

  Color pickerColor = Colors.blue;

  List<String> listMediaUseCase = <String>[];
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();
  late UserSource dataSource;
  List<UserReadDto> list = <UserReadDto>[];

  void initApp({required final VoidCallback action}) {
    state.loading();
    showLoading();
    userDataSource.filter(
      dto: UserFilterDto(),
      onResponse: (final GenericResponse<UserReadDto> onResponse) {
        list = onResponse.resultList ?? <UserReadDto>[];
        dataSource = UserSource(list);
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

  void onEditTap({required final UserReadDto dto, required final VoidCallback action}) async {
    final String? res = await Get.to(UserDetailPage(userReadDto: dto));
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


  void addListMediaUseCase() {
    const List<UseCaseMedia> listUsecaseUser = UseCaseMedia.values;
    listUsecaseUser.forEach((final UseCaseMedia element) {
      listMediaUseCase.add(element.title);
    });
  }

  void confirm({required final VoidCallback action}) {
    final UserCreateUpdateDto filter = UserCreateUpdateDto(
      userName: userNameController.text,
      phoneNumber: phoneNumberController.text,
      appEmail: appEmailController.text,
      wallet: double.parse(walletController.text),
      bio: bioController.text,
      // point: pointController.text,
      gender: genderController.text,
      color: stringToHexColor(pickerColor),
    );
    userDataSource.create(
      dto: filter,
      onResponse: (final GenericResponse<UserReadDto> response) async {
        if (listOfNewFiles.isNotEmpty) {
          await addNewFiles(response.result?.id ?? '', action: action);
        } else {
          action();
        }
      },
      onError: (final GenericResponse<dynamic> errorResponse) {},
    );
  }

  void updateUser(final UserReadDto userReadDto, {required final VoidCallback action}) {
    final UserCreateUpdateDto filter = UserCreateUpdateDto(
      id: userReadDto.id,
      userName: userNameController.text,
      phoneNumber: phoneNumberController.text,
      appEmail: appEmailController.text,
      wallet: double.parse(walletController.text),
      bio: bioController.text,
      // point: pointController.text,
      gender: genderController.text,
      color: stringToHexColor(pickerColor),
    );
    userDataSource.update(
      dto: filter,
      onResponse: (final GenericResponse<UserReadDto> response) async {
        await deleteOldFiles(
          response.result?.id ?? '',
          action: () async {
            await addNewFiles(response.result?.id ?? '', action: action);
          },
        );
      },
      onError: (final GenericResponse<dynamic> errorResponse) {},
    );
  }

  Future<void> deleteOldFiles(final String userId, {required final VoidCallback action}) async {
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
    if (listOfNewFiles.isNotEmpty) {
      for (int i = 0; i < listOfNewFiles.length; i++) {
        await mediaDataSource.createWebV2(
          useCase: listOfNewUseCase[i],
          userId: catId,
          files: <PlatformFile>[
            ...<PlatformFile>[listOfNewFiles[i]],
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

  void deleteUser({required final UserReadDto userReadDto, required final VoidCallback action}) {
    // userDataSource.delete(
    //   id: user.id ?? "",
    //   onResponse: (final GenericResponse<dynamic> response) {
    //     initApp(action: action);
    //   },
    //   onError: (final GenericResponse<dynamic> errorResponse) {
    //     initApp(action: action);
    //   },
    // );
  }
}

class UserSource extends DataGridSource {
  UserSource(final List<UserReadDto> list) {
    dataGridRow = list
        .mapIndexed<DataGridRow>(
          (final int index, final UserReadDto e) => DataGridRow(
            cells: <DataGridCell>[
              DataGridCell<int>(columnName: index.toString(), value: index),
              DataGridCell<UserReadDto>(columnName: e.id ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.userName ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.phoneNumber ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.appEmail ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.wallet?.toString() ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.bio ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.point?.toString() ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.gender ?? "", value: e),
              DataGridCell<UserReadDto>(columnName: e.color ?? "", value: e),
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
