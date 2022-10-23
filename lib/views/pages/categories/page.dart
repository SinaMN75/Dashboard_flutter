import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/controller.dart';
import 'package:dashboard/views/pages/categories/detail.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({final Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with CategoriesController {
  @override
  void initState() {
    initApp(
      action: () => setState(() {}),
    );
    dataSource = DataSource(list);
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
                final String? res = await Get.to(const CategoryDetailPage());
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
        body: _dataGrid(),
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
                  onTap: () => deleteCategory(
                    category: (row.getCells()[1]).value,
                    action: () => setState(() {}),
                  ),
                ),
                source: dataSource,
                columnResizeMode: ColumnResizeMode.onResizeEnd,
                columns: <GridColumn>[
                  GridColumn(columnName: s.order, label: gridHeader(s.order)),
                  GridColumn(columnName: s.id, label: gridHeader(s.id)),
                  GridColumn(columnName: s.title, label: gridHeader(s.title)),
                  GridColumn(columnName: s.titleTr1, label: gridHeader(s.titleTr1)),
                  GridColumn(columnName: s.titleTr2, label: gridHeader(s.titleTr2)),
                  GridColumn(columnName: s.subtitle, label: gridHeader(s.subtitle)),
                  GridColumn(columnName: s.color, label: gridHeader(s.color)),
                  GridColumn(columnName: s.link, label: gridHeader(s.link)),
                  GridColumn(columnName: s.parent, label: gridHeader(s.parent)),
                  GridColumn(columnName: s.usecase, label: gridHeader(s.usecase)),
                  GridColumn(columnName: s.type, label: gridHeader(s.type)),
                ],
              )
            : const SizedBox(),
      );
}
