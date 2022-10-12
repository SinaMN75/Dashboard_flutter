import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({required this.category, final Key? key}) : super(key: key);

  final CategoryReadDto category;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: widget.category.title ?? ""),
        drawer: drawer(),
        body: Container(),
      );
}
