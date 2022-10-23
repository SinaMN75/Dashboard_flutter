import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:dashboard/widget/dropdown.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:utilities/utilities.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({this.category, final Key? key}) : super(key: key);

  final CategoryReadDto? category;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> with CategoriesController {
  @override
  void initState() {
    addListCategoryUseCase();
    addListCategoryType();
    addListMediaUseCase();
    setParam();
    super.initState();
  }

  void setParam() {
    if (widget.category != null) {
      titleController.text = widget.category?.title ?? '';
      subTitleController.text = widget.category?.subtitle ?? '';
      pickerColor = hexStringToColor(widget.category?.color ?? '#ff067e19');
      for (int i = 0; i < listCategoryUseCase.length; i++) {
        final String p1 = listCategoryUseCase[i];
        final String p2 = widget.category?.useCase ?? '';
        if (p1 == p2) {
          selectedCategoryUseCase.value = listCategoryUseCase[i];
        }
      }
      // for (int i = 0; i < listMediaUseCase.length; i++) {
      //   final String p1 = listMediaUseCase[i];
      //   final String p2 = widget.category?.media?.first.useCase ?? '';
      //   if (p1 == p2) {
      //     selectedMediaUseCase.value = listMediaUseCase[i];
      //   }
      // }

      for (int i = 0; i < listCategoryType.length; i++) {
        final String p1 = listCategoryType[i];
        final String p2 = widget.category?.type ?? '';
        if (p1 == p2) {
          selectedCategoryType.value = listCategoryType[i];
        }
      }
    }
  }

  @override
  Widget build(final BuildContext context) =>
      scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: s.createCategory),
        drawer: drawer(),
        body: Form(
          key: globalKey,
          child: column(
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
                controller: subTitleController,
              ),
              Obx(() =>
                  AppDropDown<String>(
                    onChange: (final String value) {
                      selectedCategoryUseCase.value = value;
                    },
                    title: s.usecase,
                    icon: image(AppIcons.expansionArrow),
                    value: selectedCategoryUseCase.value,
                    items: listCategoryUseCase
                        .map(
                          (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                    )
                        .toList(),
                  )),
              Obx(() =>
                  AppDropDown<String>(
                    onChange: (final String value) {
                      selectedCategoryType.value = value;
                    },
                    title: s.type,
                    icon: image(AppIcons.expansionArrow),
                    value: selectedCategoryType.value,
                    items: listCategoryType
                        .map(
                          (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                    )
                        .toList(),
                  )),
              _selectImageWeb(),
              _selectColor(),
              widget.category != null
                  ? button(
                title: s.updateCategory,
                onTap: () {
                  validateForm(
                    key: globalKey,
                    action: () {
                      updateCategory(widget.category!, action: () => Get.back(result: BackResult.ok.title));
                    },
                  );
                },
              )
                  : button(
                title: s.confirm,
                onTap: () {
                  validateForm(
                    key: globalKey,
                    action: () {
                      confirm(
                        action: () => Get.back(result: BackResult.ok.title),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget _selectImageWeb() =>
      iconTextVertical(
        crossAxisAlignment: CrossAxisAlignment.start,
        leading: formLabel(s.picture),
        trailing: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: Obx(() =>
                    AppDropDown<String>(
                      onChange: (final String value) {
                        selectedMediaUseCase.value = value;
                      },
                      title: s.usecase,
                      icon: image(AppIcons.expansionArrow),
                      value: selectedMediaUseCase.value,
                      items: listMediaUseCase
                          .map(
                            (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                          .toList(),
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: context.theme.primaryColor),
                ),
                child: iconTextHorizontal(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  leading: image(AppIcons.email, width: 20, height: 40, color: context.theme.primaryColor),
                  trailing: Text(s.uploadPhoto).subtitle1(color: context.theme.primaryColor),
                ),
              ).onTap(
                    () =>
                    showFilePickerWeb(
                      action: (final PlatformFile file) {
                        imagess.add(file);
                        setState(() {});
                      },
                    ),
              ),
              Container(
                child: imagess.isNotEmpty || filess.isNotEmpty
                    ? Container()
                    : widget.category?.media?.isNotEmpty ?? false ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: image(widget.category?.media?.first.url ?? ''),
                ):Container(),
              ),
              ...imagess
                  .map(
                    (final PlatformFile e) =>
                    Stack(
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
                            onTap: () =>
                                setState(() {
                                  imagess.remove(e);
                                })),
                      ],
                    ).marginSymmetric(horizontal: 10),
              )
                  .toList()
            ],
          ),
        ),
      );

  Widget _selectColor() {
    Color currentColor = hexToColor(widget.category?.color ?? "#1976D2");
    return button(
      onTap: () {
        showDialog(
          context: context,
          builder: (final BuildContext context) =>
              AlertDialog(
                title: const Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: (final Color value) =>
                        setState(() {
                          currentColor = value;
                        }),
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Got it'),
                    onPressed: () {
                      setState(() => pickerColor = currentColor);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
      },
      title: 'dd',
      backgroundColor: pickerColor,
    );
  }

  Widget formLabel(final String text) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: context.theme.textTheme.headline6,
        ),
      );
}
