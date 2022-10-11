import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/controller.dart';
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
    dataSource = DataSource(list);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: s.users),
        drawer: drawer(),
        body: _dataGrid(),
      );

  Widget _dataGrid() => SfDataGrid(
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        allowFiltering: true,
        allowMultiColumnSorting: true,
        allowSwiping: true,
        allowColumnsResizing: true,
        gridLinesVisibility: GridLinesVisibility.both,
        startSwipeActionsBuilder: (final _, final DataGridRow row, final __) => gridSwipeButton(
          title: s.edit,
          backgroundColor: Colors.blueAccent,
          onTap: () => onEditTap(dto: row.getCells().first.value),
        ),
        endSwipeActionsBuilder: (final _, final DataGridRow row, final __) => gridSwipeButton(
          title: s.delete,
          backgroundColor: Colors.red,
          onTap: () => onDeleteTap(dto: row.getCells().first.value),
        ),
        source: dataSource,
        columns: <GridColumn>[
          GridColumn(columnName: s.id, label: gridHeader(s.id)),
          GridColumn(columnName: s.title, label: gridHeader(s.title)),
          GridColumn(columnName: s.titleTr1, label: gridHeader(s.titleTr1)),
          GridColumn(columnName: s.titleTr2, label: gridHeader(s.titleTr2)),
        ],
      );
}
