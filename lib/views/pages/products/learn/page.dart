import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/products/learn/controller.dart';
import 'package:dashboard/views/pages/products/learn/create.dart';
import 'package:dashboard/views/pages/products/tenders/create.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

class LearnProductPage extends StatefulWidget {
  const LearnProductPage({final Key? key}) : super(key: key);

  @override
  State<LearnProductPage> createState() => _LearnProductPageState();
}

class _LearnProductPageState extends State<LearnProductPage> with LearnProductController {
  @override
  void initState() {
    getProducts(action: () => dataSource.value = DataSource(list));
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(
          title: "Lest Learn products",
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: exportDataGridToPdf,
            ),
            IconButton(
              icon: const Icon(Icons.add_box_sharp),
              onPressed: () => push(
                LearnCreatePage(onBack: () => getProducts(action: () => dataSource.value = DataSource(list))),
              ),
            ),
          ],
        ),
        drawer: drawer(),
        body: _dataGrid(),
      );

  Widget _dataGrid() => Obx(
        () => SfDataGrid(
          key: gridKey,
          columnWidthMode: ColumnWidthMode.auto,
          allowSorting: true,
          allowFiltering: true,
          allowMultiColumnSorting: true,
          allowSwiping: true,
          allowColumnsResizing: true,
          gridLinesVisibility: GridLinesVisibility.both,
          startSwipeActionsBuilder: (final _, final DataGridRow row, final __) => gridSwipeButton(
            title: s.edit,
            backgroundColor: Colors.blueAccent,
            onTap: () => push(
              LearnCreatePage(
                  onBack: () => getProducts(
                        action: () => dataSource.value = DataSource(list),
                      ),
                  product: (row.getCells()[1]).value),
            ),
          ),
          endSwipeActionsBuilder: (final _, final DataGridRow row, final int index) => gridSwipeButton(
            title: s.delete,
            backgroundColor: Colors.red,
            onTap: () => deleteProduct(
              id: (row.getCells()[1]).value.id,
              action: () => getProducts(action: () => dataSource.value = DataSource(list)),
            ),
          ),
          source: dataSource.value,
          columnResizeMode: ColumnResizeMode.onResizeEnd,
          columns: <GridColumn>[
            GridColumn(columnName: s.order, label: gridHeader(s.order)),
            GridColumn(columnName: s.title, label: gridHeader(s.title)),
            GridColumn(columnName: "description", label: gridHeader("description")),
            GridColumn(columnName: "address", label: gridHeader("address")),
            GridColumn(columnName: s.phoneNumber, label: gridHeader(s.phoneNumber)),
            GridColumn(columnName: "email", label: gridHeader("email")),
            GridColumn(columnName: "state", label: gridHeader("state")),
            GridColumn(columnName: "latitude", label: gridHeader("latitude")),
            GridColumn(columnName: "longitude", label: gridHeader("longitude")),
            GridColumn(columnName: "price", label: gridHeader("price")),
          ],
        ),
      );
}
