import 'package:dashboard/core/core.dart';
import 'package:dashboard/widget/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:utilities/components/components.dart';

class CustomAppDown extends StatefulWidget {
  CustomAppDown({required this.selectCase, final Key? key}) : super(key: key);

  Function(String selectMediaUseCase) selectCase;

  @override
  State<CustomAppDown> createState() => _CustomAppDownState();
}

class _CustomAppDownState extends State<CustomAppDown> {
  List<String> listMediaUseCase = <String>[];
  String selectMediaUseCase = '';

  void addListMediaUseCase() {
    const List<UseCaseMedia> listUsecaseCategory = UseCaseMedia.values;
    listUsecaseCategory.forEach((final UseCaseMedia element) {
      listMediaUseCase.add(element.title);
    });
    selectMediaUseCase = listMediaUseCase.first;
  }

  @override
  void initState() {
    addListMediaUseCase();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => AppDropDown<String>(
        onChange: (final String value) {
          setState(() {
            selectMediaUseCase = value;
            widget.selectCase(selectMediaUseCase);
          });
        },
        title: s.usecase,
        icon: image(AppIcons.expansionArrow),
        value: selectMediaUseCase,
        items: listMediaUseCase
            .map(
              (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
            )
            .toList(),
      );
}
