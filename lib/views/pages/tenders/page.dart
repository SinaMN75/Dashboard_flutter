import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/tenders/controller.dart';
import 'package:dashboard/views/pages/tenders/detail.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

class TendersPage extends StatefulWidget {
  const TendersPage({final Key? key}) : super(key: key);

  @override
  State<TendersPage> createState() => _TendersPageState();
}

class _TendersPageState extends State<TendersPage> with TendersController {
  @override
  void initState() {
    initApp(
      action: () => setState(() {}),
    );
    dataSource = DataSource(list);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: appbar(
          title: s.category,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: exportDataGridToPdf,
            ),
            IconButton(
              icon: const Icon(Icons.add_box_sharp),
              // onPressed: () => push(const CategoryDetailPage()),
              onPressed: () async {
                final String? res = await Get.to(const TendersDetailPage());
                if (res == BackResult.ok.title) {
                  initApp(
                    action: () => setState(() {}),
                  );
                }
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                AppImages.backImage,
                repeat: ImageRepeat.repeat,
              ),
            ),
            Center(
              child: Container(
                width: 930,
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: appDecoration(),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: SfDataGrid(
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
                        GridColumn(columnName: s.title, label: gridHeader(s.title)),
                        GridColumn(columnName: s.subtitle, label: gridHeader(s.subtitle)),
                        GridColumn(columnName: s.titleTr1, label: gridHeader(s.titleTr1)),
                        GridColumn(columnName: s.titleTr2, label: gridHeader(s.titleTr2)),
                        GridColumn(columnName: s.color, label: gridHeader(s.color)),
                        GridColumn(columnName: s.link, label: gridHeader(s.link)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

}
