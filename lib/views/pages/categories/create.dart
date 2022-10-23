import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:dashboard/widget/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({ final Key? key}) : super(key: key);


  @override
  State<CategoryCreatePage> createState() => _CategoryCreatePageState();
}

class _CategoryCreatePageState extends State<CategoryCreatePage> with CategoriesController{

  @override
  void initState() {
    addListCategoryUseCase();
    super.initState();
  }
  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: s.createCategory ?? ""),
        drawer: drawer(),
        body: Column(
          children: <Widget>[
            textFormField(
              label: s.title,
            titleWidth: 100,
              onChanged: (final String value) {},
              controller: titleController,
            ),
            textFormField(
              label: s.subtitle,
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: titleController,
            ),
            Obx(()=> AppDropDown<String>(
                onChange: (final String value) {
                  selectedCategoryUseCase.value=value;
                },
                title: s.title,
                icon: image(AppIcons.expansionArrow),
                value: selectedCategoryUseCase.value,
                items: listCategoryUseCase
                    .map(
                      (final String e) => DropdownMenuItem<String>(value: e, child: Text(e ?? "")),
                )
                    .toList(),
              )),


          ],
        ),
      );
}
