import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/products/ads/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class AdsDetailPage extends StatefulWidget {
  const AdsDetailPage({this.category, final Key? key}) : super(key: key);

  final CategoryReadDto? category;

  @override
  State<AdsDetailPage> createState() => _AdsDetailPageState();
}

class _AdsDetailPageState extends State<AdsDetailPage> with AdsProductController {
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
