import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/products/ads/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:dashboard/widget/dropdown.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utilities/utilities.dart';

class AdsCreatePage extends StatefulWidget {
  const AdsCreatePage({required this.onBack, this.product, final Key? key}) : super(key: key);
  final ProductReadDto? product;
  final VoidCallback onBack;
  @override
  State<AdsCreatePage> createState() => _AdsCreatePageState();
}

class _AdsCreatePageState extends State<AdsCreatePage> with AdsProductController {
  late List<MediaReadDto> medias;

  @override
  void initState() {
    medias = widget.product?.media ?? <MediaReadDto>[];
    if (widget.product != null) {
      titleController.text = widget.product?.title ?? "";
      descriptionController.text = widget.product?.description ?? "";
      addressController.text = widget.product?.address ?? "";
      phoneNumberController.text = widget.product?.phoneNumber ?? "";
      emailController.text = widget.product?.email ?? "";
      stateController.text = widget.product?.state ?? "";
      latitudeController.text = widget.product?.latitude.toString() ?? "";
      longitudeController.text = widget.product?.longitude.toString() ?? "";
      priceController.text = widget.product?.price.toString() ?? "";
      longitudeController.text = widget.product?.longitude.toString() ?? "";
      if (widget.product!.categories != null && widget.product!.categories!.isNotEmpty) {
        selectedCategory.value = widget.product!.categories!.first;
      }
    }
    getCategorise();
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
              onChanged: (final String value) {},
              controller: titleController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "description",
              onChanged: (final String value) {},
              controller: descriptionController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "address",
              onChanged: (final String value) {},
              controller: addressController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "phoneNumber",
              onChanged: (final String value) {},
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              textFormat: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "email",
              onChanged: (final String value) {},
              controller: emailController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "state",
              onChanged: (final String value) {},
              controller: stateController,
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "latitude",
              onChanged: (final String value) {},
              controller: latitudeController,
              keyboardType: TextInputType.phone,
              textFormat: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "longitude",
              onChanged: (final String value) {},
              controller: longitudeController,
              keyboardType: TextInputType.phone,
              textFormat: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ).marginSymmetric(vertical: 10),
            textFormField(
              label: "price",
              onChanged: (final String value) {},
              controller: priceController,
            ).marginSymmetric(vertical: 10),
            Obx(
              () => categorise.isEmpty
                  ? const SizedBox()
                  : AppDropDown<CategoryReadDto>(
                      onChange: (final CategoryReadDto c) => selectedCategory.value = c,
                      value: selectedCategory.value,
                      items: categorise
                          .map(
                            (final CategoryReadDto e) => DropdownMenuItem<CategoryReadDto>(
                              value: e,
                              child: Text(e.title ?? "--"),
                            ),
                          )
                          .toList(),
                    ),
            ),
            _selectImageWeb(),
            button(
              onTap: () => widget.product == null
                  ? createProduct(
                      catId: selectedCategory.value.id,
                      action: () {
                        back();
                        widget.onBack();
                      },
                    )
                  : editProduct(
                      id: widget.product!.id!,
                      catId: selectedCategory.value.id,
                      action: () {
                        back();
                        widget.onBack();
                      },
                    ),
              title: widget.product != null ? "Edit" : "Create",
              maxWidth: true,
            ).marginSymmetric(vertical: 30),
          ],
        ).marginSymmetric(horizontal: 20),
      );

  Widget _selectImageWeb() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: context.theme.disabledColor.withOpacity(0.6)),
              ),
              child: iconTextHorizontal(
                leading: image(AppIcons.image, width: 20, height: 40, color: context.theme.primaryColor),
                trailing: Text(s.selectImage).subtitle1(color: context.theme.primaryColor),
              ),
            ).onTap(
              () => showFilePickerWeb(
                action: (final PlatformFile file) {
                  listOfNewImage.add(file);
                  if (medias.getByUseCase(useCase: UseCaseMedia.image.title).isNotEmpty) {
                    listOfDeleteFile.add(medias.getByUseCase(useCase: UseCaseMedia.image.title).first.id);
                  }
                  setState(() {});
                },
              ),
            ),
            Container(
              child: listOfNewImage.isNotEmpty
                  ? Container()
                  : medias.getByUseCase(useCase: UseCaseMedia.image.title).isNotEmpty
                      ? !listOfDeleteFile.contains(medias.getByUseCase(useCase: UseCaseMedia.image.title).first.id)
                          ? Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: image(
                                    medias.getByUseCase(useCase: UseCaseMedia.image.title).first.url,
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                image(
                                  AppIcons.close,
                                  width: 20,
                                  onTap: () => setState(
                                    () {
                                      // if (widget.category?.media?.getByUseCase(useCase: UseCaseMedia.image.title).isNotEmpty ?? false) {
                                      //   listOfDeleteFile.add(widget.category?.media?.getByUseCase(useCase: UseCaseMedia.image.title).first.id ?? '');
                                      // }
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container()
                      : Container(),
            ),
            ...listOfNewImage
                .map(
                  (final PlatformFile e) => Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.memory(e.bytes!, width: 45, height: 45, fit: BoxFit.scaleDown),
                      ),
                      image(AppIcons.close,
                          width: 20,
                          onTap: () => setState(() {
                                listOfNewImage.remove(e);
                              })),
                    ],
                  ).marginSymmetric(horizontal: 10),
                )
                .toList()
          ],
        ),
      );
}
