import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/detail.dart';
import 'package:dashboard/views/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

mixin CategoriesController {
  late DataSource dataSource;
  List<CategoryReadDto> list = App.categories.where((final CategoryReadDto element) => element.useCase == "category").toList();

  void onEditTap({required final CategoryReadDto dto}) => push(CategoryDetailPage(category: dto));

  void onDeleteTap({required final CategoryReadDto dto}) => push(CategoryDetailPage(category: dto));
}

class DataSource extends DataGridSource {
  DataSource(final List<CategoryReadDto> list) {
    dataGridRow = list
        .map<DataGridRow>(
          (final CategoryReadDto e) => DataGridRow(
            cells: <DataGridCell>[
              DataGridCell<CategoryReadDto>(columnName: e.id ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.title ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.titleTr1 ?? "", value: e),
              DataGridCell<CategoryReadDto>(columnName: e.titleTr2 ?? "", value: e),
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
