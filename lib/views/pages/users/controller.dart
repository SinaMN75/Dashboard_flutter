import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:utilities/utilities.dart';

mixin UsersController {
  late UserDataSources dataSource;
  late List<UserReadDto> userList;

  List<UserReadDto> users() => <UserReadDto>[
        UserReadDto(id: "111", fullName: "111", phoneNumber: "111"),
        UserReadDto(id: "222", fullName: "222", phoneNumber: "222"),
        UserReadDto(id: "333", fullName: "333", phoneNumber: "333"),
        UserReadDto(id: "444", fullName: "444", phoneNumber: "444"),
      ];
}

class UserDataSources extends DataGridSource {
  UserDataSources(final List<UserReadDto> users) {
    dataGridRow = users
        .map<DataGridRow>(
          (final UserReadDto e) => DataGridRow(
            cells: <DataGridCell>[
              DataGridCell<String>(columnName: "Id", value: e.id),
              DataGridCell<String>(columnName: "FullName", value: e.fullName),
              DataGridCell<String>(columnName: "PhoneNumber", value: e.phoneNumber),
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
              (final DataGridCell e) => GestureDetector(
                onDoubleTap: () {
                  print(e.value);
                },
                child: Text(e.value.toString()).headline1(color: Colors.red),
              ),
            )
            .toList(),
      );
}
