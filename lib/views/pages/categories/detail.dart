import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({ this.category, final Key? key}) : super(key: key);

  final CategoryReadDto? category;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> with CategoriesController {
  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: widget.category?.title ?? ""),
        drawer: drawer(),
        body: Column(
          children: <Widget>[
            textFormField(
              label: s.title,
              onChanged: (final String value) {},
              controller: titleController,
            ),
            textFormField(
              label: s.subtitle,
              onChanged: (final String value) {},
              controller: titleController,
            ),


          ],
        ),
      );
}
