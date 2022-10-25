import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/user/controller.dart';
import 'package:dashboard/views/pages/user/detail.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

class UserPage extends StatefulWidget {
  const UserPage({final Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with UserController {
  @override
  void initState() {
    initApp(
      action: () => setState(() {}),
    );
    dataSource = UserSource(list);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(
          title: s.users,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: exportDataGridToPdf,
            ),
            IconButton(
              icon: const Icon(Icons.add_box_sharp),
              // onPressed: () => push(const CategoryDetailPage()),
              onPressed: () async {
                final String? res = await Get.to(const UserDetailPage());
                if (res == BackResult.ok.title) {
                  initApp(
                    action: () => setState(() {}),
                  );
                }
              },
            ),
          ],
        ),
        drawer: drawer(),
        body: Center(
        // ignore: use_decorated_box
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _dataGrid())),
      );

  Widget _dataGrid() => Obx(
        () => state.isLoaded()
            ? SfDataGrid(
                key: gridKey,
                columnWidthMode: ColumnWidthMode.auto,
                allowSorting: true,
                allowFiltering: true,
                allowMultiColumnSorting: true,
                allowSwiping: true,
                gridLinesVisibility: GridLinesVisibility.both,
                startSwipeActionsBuilder: (final _, final DataGridRow row, final __) => gridSwipeButton(
                  title: s.edit,
                  backgroundColor: Colors.blueAccent,
                  onTap: () => onEditTap(dto: (row.getCells()[1]).value, action: () => setState(() {})),
                ),
                endSwipeActionsBuilder: (final _, final DataGridRow row, final __) => gridSwipeButton(
                  title: s.delete,
                  backgroundColor: Colors.red,
                  onTap: () => deleteUser(
                    userReadDto: (row.getCells()[1]).value,
                    action: () => setState(() {}),
                  ),
                ),
                source: dataSource,
                columnResizeMode: ColumnResizeMode.onResizeEnd,
                columns: <GridColumn>[
                  GridColumn(columnName: s.order, label: gridHeader(s.order)),
                  GridColumn(columnName: s.id, label: gridHeader(s.id)),
                  GridColumn(columnName: s.userName, label: gridHeader(s.userName)),
                  GridColumn(columnName: s.phoneNumber, label: gridHeader(s.phoneNumber)),
                  GridColumn(columnName: s.appEmail, label: gridHeader(s.appEmail)),
                  GridColumn(columnName: s.wallet, label: gridHeader(s.wallet)),
                  GridColumn(columnName: s.bio, label: gridHeader(s.bio)),
                  GridColumn(columnName: s.point, label: gridHeader(s.point)),
                  GridColumn(columnName: s.gender, label: gridHeader(s.gender)),
                  GridColumn(columnName: s.color, label: gridHeader(s.color)),
                ],
              )
            : const SizedBox(),
      );
}
