import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/users/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({final Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> with UsersController {
  @override
  void initState() {
    userList = users();
    dataSource = UserDataSources(userList);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => scaffold(
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
        startSwipeActionsBuilder: _startSwipeWidget,
        source: dataSource,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'Id',
            label: Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Id', overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: 'Name',
            label: Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Name', overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: 'PhoneNumber',
            label: Container(
              padding: const EdgeInsets.all(8),
              child: const Text('PhoneNumber', overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      );

  Widget _startSwipeWidget(final BuildContext context, final DataGridRow row, final int rowIndex) => GestureDetector(
        onTap: () => _handleEditWidgetTap(row),
        child: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.edit, color: Colors.white, size: 20),
              SizedBox(width: 16),
              Text('EDIT', style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
      );

  void _handleEditWidgetTap(final DataGridRow row) {
    print(row.getCells().first.value);
  }
}
