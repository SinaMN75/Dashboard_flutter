import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/tenders/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:utilities/utilities.dart';

class TendersDetailPage extends StatefulWidget {
  const TendersDetailPage({this.category, final Key? key}) : super(key: key);

  final CategoryReadDto? category;

  @override
  State<TendersDetailPage> createState() => _TendersDetailPageState();
}

class _TendersDetailPageState extends State<TendersDetailPage> with TendersController {
  late List<MediaReadDto> medias;

  @override
  void initState() {
    medias = widget.category?.media! ?? <MediaReadDto>[];
    // addListCategoryUseCase();
    // addListCategoryType();
    // addListMediaUseCase();

    setParam();
    super.initState();
  }

  void setParam() {
    if (widget.category != null) {
      titleController.text = widget.category?.title ?? '';
      subTitleController.text = widget.category?.subtitle ?? '';
      titleTr1Controller.text = widget.category?.titleTr1 ?? '';
      titleTr2Controller.text = widget.category?.titleTr2 ?? '';
      linkController.text = widget.category?.link ?? '';
      pickerColor = hexStringToColor(widget.category?.color ?? '#ff067e19');
      // for (int i = 0; i < listCategoryUseCase.length; i++) {
      //   final String p1 = listCategoryUseCase[i];
      //   final String p2 = widget.category?.useCase ?? '';
      //   if (p1 == p2) {
      //     selectedCategoryUseCase.value = listCategoryUseCase[i];
      //   }
      // }
      // for (int i = 0; i < listMediaUseCase.length; i++) {
      //   final String p1 = listMediaUseCase[i];
      //   final String p2 = widget.category?.media?.first.useCase ?? '';
      //   if (p1 == p2) {
      //     selectedMediaUseCase.value = listMediaUseCase[i];
      //   }
      // }
      //
      // for (int i = 0; i < listCategoryType.length; i++) {
      //   final String p1 = listCategoryType[i];
      //   final String p2 = widget.category?.type ?? '';
      //   if (p1 == p2) {
      //     selectedCategoryType.value = listCategoryType[i];
      //   }
      // }
    }
  }

  @override
  Widget build(final BuildContext context) => scaffold(
        constraints: const BoxConstraints(minWidth: 1000),
        appBar: appbar(title: s.createTenders),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                AppImages.backImage,
                repeat: ImageRepeat.repeat,
              ),
            ),
            Center(
              // ignore: use_decorated_box
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: appDecoration(),
                child: Center(
                  child: Form(
                    key: globalKey,
                    child: column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      isScrollable: true,
                      children: <Widget>[
                        Text(widget.category != null ? s.updateCategory : s.createCategory).headline6(fontSize: 24, fontWeight: FontWeight.bold).marginSymmetric(vertical: 16, horizontal: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: textFormField(
                            label: s.title,
                            onChanged: (final String value) {},
                            controller: titleController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: textFormField(
                            label: s.subtitle,
                            onChanged: (final String value) {},
                            controller: subTitleController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: textFormField(
                            label: s.titleTr1,
                            onChanged: (final String value) {},
                            controller: titleTr1Controller,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: textFormField(
                            label: s.titleTr2,
                            onChanged: (final String value) {},
                            controller: titleTr2Controller,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: textFormField(
                            label: s.link,
                            onChanged: (final String value) {},
                            controller: linkController,
                          ),
                        ),

                        // Container(color: Colors.red, width: screenWidth, height: 200, child: listFiles(widget.category)),
                        // _selectImageWeb(),
                        // listNewFiles(widget.category),
                        const SizedBox(height: 16),
                        _selectImageWeb().marginOnly(bottom: 16, left: 16),
                        _selectFileWeb().marginOnly(bottom: 16, left: 16),
                        _selectColor().marginOnly(bottom: 16, left: 16),
                        widget.category != null
                            ? SizedBox(
                                width: screenWidth,
                                child: button(
                                  title: s.updateCategory,
                                  backgroundColor: context.theme.focusColor,
                                  onTap: () {
                                    validateForm(
                                      key: globalKey,
                                      action: () {
                                        updateCategory(widget.category!, action: () => Get.back(result: BackResult.ok.title));
                                      },
                                    );
                                  },
                                ),
                              ).marginOnly(bottom: 8, left: 16)
                            : SizedBox(
                                width: screenWidth,
                                child: button(
                                  title: s.confirm,
                                  backgroundColor: context.theme.focusColor,
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
                                ).marginOnly(bottom: 8, left: 16),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                                  child: image(medias.getByUseCase(useCase: UseCaseMedia.image.title).first.url, width: 45, height: 45, fit: BoxFit.scaleDown),
                                ),
                                image(AppIcons.close,
                                    width: 20,
                                    onTap: () => setState(() {
                                          if (widget.category?.media?.getByUseCase(useCase: UseCaseMedia.image.title).isNotEmpty ?? false) {
                                            listOfDeleteFile.add(widget.category?.media?.getByUseCase(useCase: UseCaseMedia.image.title).first.id ?? '');
                                          }
                                        })),
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

  Widget _selectFileWeb() => SingleChildScrollView(
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
                leading: image(AppIcons.singlePost, width: 20, height: 40, color: context.theme.primaryColor),
                trailing: Text(s.selectFile).subtitle1(color: context.theme.primaryColor),
              ),
            ).onTap(
              () => showFilePickerWeb(
                fileType: FileType.any,
                action: (final PlatformFile file) {
                  listOfNewFile.add(file);
                  if (widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).isNotEmpty ?? false) {
                    listOfDeleteFile.add(widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).first.id ?? '');
                  }
                  setState(() {});
                },
              ),
            ),
            Container(
              child: listOfNewFile.isNotEmpty
                  ? Container()
                  : widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).isNotEmpty ?? false
                      ? !listOfDeleteFile.contains(widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).first.id ?? '')
                          ? Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // child: image(widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).first.url ?? ''),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: image(AppIcons.singlePost, width: 45, height: 45, fit: BoxFit.scaleDown),
                                  ),
                                  image(AppIcons.close,
                                      width: 20,
                                      onTap: () => setState(() {
                                            if (widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).isNotEmpty ?? false) {
                                              listOfDeleteFile.add(widget.category?.media?.getByUseCase(useCase: UseCaseMedia.all.title).first.id ?? '');
                                            }
                                          })),
                                ],
                              ),
                            )
                          : Container()
                      : Container(),
            ),
            ...listOfNewFile
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
                                listOfNewFile.remove(e);
                              })),
                    ],
                  ).marginSymmetric(horizontal: 10),
                )
                .toList()
          ],
        ),
      );

  Widget listFiles(final CategoryReadDto? categoryReadDto) {
    final List<MediaReadDto> mediaList = categoryReadDto?.media ?? <MediaReadDto>[];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mediaList.length,
      itemBuilder: (final BuildContext context, final int index) => Column(
        children: <Widget>[
          image(
            mediaList[index].url,
            width: 64,
            height: 64,
          ),
          Text(mediaList[index].useCase),
          button(
              onTap: () {
                listOfDeleteFile.add(mediaList[index].id);
                mediaList.removeAt(index);
                setState(() {});
              },
              title: s.delete),
        ],
      ),
    );
  }

  // Widget _selectListNewFile() => iconTextVertical(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       leading: formLabel(s.files),
  //       trailing: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: <Widget>[
  //             SizedBox(
  //               width: 200,
  //               child: Obx(() => AppDropDown<String>(
  //                     onChange: (final String value) {
  //                       selectedMediaUseCase.value = value;
  //                     },
  //                     title: s.usecase,
  //                     icon: image(AppIcons.expansionArrow),
  //                     value: selectedMediaUseCase.value,
  //                     items: listMediaUseCase
  //                         .map(
  //                           (final String e) => DropdownMenuItem<String>(value: e, child: Text(e)),
  //                         )
  //                         .toList(),
  //                   )),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               width: 150,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 border: Border.all(color: context.theme.primaryColor),
  //               ),
  //               child: iconTextHorizontal(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 leading: image(AppIcons.email, width: 20, height: 40, color: context.theme.primaryColor),
  //                 trailing: Text(s.uploadPhoto).subtitle1(color: context.theme.primaryColor),
  //               ),
  //             ).onTap(
  //               () => showFilePickerWeb(
  //                 action: (final PlatformFile file) {
  //                   listOfNewFiles.add(file);
  //                   setState(() {});
  //                 },
  //               ),
  //             ),
  //             Container(
  //               child: listOfNewFiles.isNotEmpty
  //                   ? Container()
  //                   : widget.category?.media?.isNotEmpty ?? false
  //                       ? Container(
  //                           height: 50,
  //                           width: 50,
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           child: image(widget.category?.media?.first.url ?? ''),
  //                         )
  //                       : Container(),
  //             ),
  //             ...listOfNewFiles
  //                 .map(
  //                   (final PlatformFile e) => Stack(
  //                     alignment: Alignment.topRight,
  //                     children: <Widget>[
  //                       Container(
  //                         height: 50,
  //                         width: 50,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(15),
  //                         ),
  //                         child: Image.memory(e.bytes!, width: 45, height: 45, fit: BoxFit.scaleDown),
  //                       ),
  //                       image(AppIcons.close,
  //                           width: 20,
  //                           onTap: () => setState(() {
  //                                 listOfNewFiles.remove(e);
  //                               })),
  //                     ],
  //                   ).marginSymmetric(horizontal: 10),
  //                 )
  //                 .toList()
  //           ],
  //         ),
  //       ),
  //     );

  // Widget listNewFiles(final CategoryReadDto? categoryReadDto) => SizedBox(
  //       width: screenWidth,
  //       height: 200,
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: listOfNewFiles.length + 1,
  //         itemBuilder: (final BuildContext context, final int index) {
  //           if (index == listOfNewFiles.length) {
  //             return Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               width: 150,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 border: Border.all(color: context.theme.primaryColor),
  //               ),
  //               child: iconTextHorizontal(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 leading: image(AppIcons.email, width: 20, height: 40, color: context.theme.primaryColor),
  //                 trailing: Text(s.uploadPhoto).subtitle1(color: context.theme.primaryColor),
  //               ),
  //             ).onTap(
  //               () => showFilePickerWeb(
  //                 action: (final PlatformFile file) {
  //                   listOfNewFiles.add(file);
  //                   setState(() {});
  //                 },
  //               ),
  //             );
  //           } else {
  //             return Column(
  //               children: <Widget>[
  //                 Stack(
  //                   alignment: Alignment.topRight,
  //                   children: <Widget>[
  //                     Container(
  //                       height: 50,
  //                       width: 50,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(15),
  //                       ),
  //                       child: Image.memory(listOfNewFiles[index].bytes!, width: 45, height: 45, fit: BoxFit.scaleDown),
  //                     ),
  //                     image(AppIcons.close,
  //                         width: 20,
  //                         onTap: () => setState(() {
  //                               listOfNewFiles.remove(listOfNewFiles[index]);
  //                               listOfNewUseCase.remove(listOfNewUseCase[index]);
  //                               useCaseMedia2.remove(useCaseMedia2[index]);
  //                             })),
  //                   ],
  //                 ).marginSymmetric(horizontal: 10),
  //                 SizedBox(
  //                   width: 200,
  //                   child: CustomAppDown(
  //                     selectCase: (final String selectMediaUseCase) {
  //                       listOfNewUseCase.removeAt(index);
  //                       listOfNewUseCase.insert(index, selectMediaUseCase);
  //                     },
  //                   ),
  //                 ),
  //
  //                 // Text(mediaList[index].useCase),
  //                 // button(onTap: () {
  //                 //   listOfDeleteFile.add(mediaList[index].id ?? '');
  //                 //   mediaList.removeAt(index);
  //                 //   setState(() {
  //                 //
  //                 //   });
  //                 // }, title: s.delete),
  //               ],
  //             );
  //           }
  //         },
  //       ),
  //     );

  Widget _selectColor() {
    Color currentColor = hexToColor(widget.category?.color ?? "#1976D2");

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: context.theme.disabledColor.withOpacity(0.6)),
          ),
          child: Center(
            child: Text(s.selectColor).subtitle1(color: context.theme.primaryColor),
          ),
        ).onTap(() {
          showDialog(
            context: context,
            builder: (final BuildContext context) => AlertDialog(
              title: Text(s.pickColor),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (final Color value) => setState(() {
                    currentColor = value;
                  }),
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text(s.select),
                  onPressed: () {
                    setState(() => pickerColor = currentColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }),

        // button(
        //   title: s.selectColor,
        //   onTap: () {
        //     showDialog(
        //       context: context,
        //       builder: (final BuildContext context) => AlertDialog(
        //         title: Text(s.pickColor),
        //         content: SingleChildScrollView(
        //           child: ColorPicker(
        //             pickerColor: pickerColor,
        //             onColorChanged: (final Color value) => setState(() {
        //               currentColor = value;
        //             }),
        //           ),
        //         ),
        //         actions: <Widget>[
        //           ElevatedButton(
        //             child: Text(s.select),
        //             onPressed: () {
        //               setState(() => pickerColor = currentColor);
        //               Navigator.of(context).pop();
        //             },
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        const SizedBox(
          width: 8,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 30,
            height: 30,
            color: pickerColor,
          ),
        )
      ],
    );

    // return button(
    //   onTap: () {
    //     showDialog(
    //       context: context,
    //       builder: (final BuildContext context) => AlertDialog(
    //         title: Text(s.pickColor),
    //         content: SingleChildScrollView(
    //           child: ColorPicker(
    //             pickerColor: pickerColor,
    //             onColorChanged: (final Color value) => setState(() {
    //               currentColor = value;
    //             }),
    //           ),
    //         ),
    //         actions: <Widget>[
    //           ElevatedButton(
    //             child: Text(s.select),
    //             onPressed: () {
    //               setState(() => pickerColor = currentColor);
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   title: s.color,
    //   backgroundColor: pickerColor,
    // );
  }

  Widget formLabel(final String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: context.theme.textTheme.headline6,
        ),
      );
}
