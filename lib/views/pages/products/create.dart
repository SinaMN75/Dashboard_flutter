import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/products/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:dashboard/widget/dropdown.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class ProductCreatePage extends StatefulWidget {
  const ProductCreatePage({final Key? key}) : super(key: key);

  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> with ProductsController {
  @override
  void initState() {
    addListProductUseCase();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: "create product"),
        drawer: drawer(),
        body: column(
          isScrollable: true,
          children: <Widget>[
            textFormField(
              label: s.title,
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: titleController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: s.subtitle,
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: titleController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "description",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: descriptionController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "details",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: detailsController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "address",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: addressController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "author",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: authorController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "phoneNumber",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: phoneNumberController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "link",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: linkController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "email",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: emailController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "state",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: stateController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "stateTr1",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: stateTr1Controller,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "stateTr2",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: stateTr2Controller,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "latitude",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: latitudeController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "longitude",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: longitudeController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "price",
              titleWidth: 100,
              onChanged: (final String value) {},
              controller: priceController,
            ).marginSymmetric(vertical: 10),
            Obx(() => AppDropDown<String>(
                  onChange: (final String value) {
                    selectedProductUseCase.value = value;
                  },
                  title: s.usecase,
                  icon: image(AppIcons.expansionArrow),
                  value: selectedProductUseCase.value,
                  items: listProductUseCase
                      .map(
                        (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
                )),
            Obx(() => AppDropDown<String>(
                  onChange: (final String value) {
                    selectedProductType.value = value;
                  },
                  title: "type",
                  icon: image(AppIcons.expansionArrow),
                  value: selectedProductType.value,
                  items: listProductType
                      .map(
                        (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
                )),
            button(onTap: (){},title: "Create",maxWidth: true).marginSymmetric(vertical: 30),
          ],
        ).marginSymmetric(horizontal: 20),
      );
}
