import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/custom_app_down.dart';
import 'package:dashboard/views/pages/user/controller.dart';
import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:dashboard/views/widgets/form.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:utilities/utilities.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({this.userReadDto, final Key? key}) : super(key: key);

  final UserReadDto? userReadDto;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> with UserController {
  @override
  void initState() {
    // addListCategoryUseCase();
    // addListCategoryType();
    addListMediaUseCase();
    setParam();
    super.initState();
  }

  void setParam() {
    if (widget.userReadDto != null) {
      userNameController.text = widget.userReadDto?.userName ?? '';
      phoneNumberController.text = widget.userReadDto?.phoneNumber ?? '';
      appEmailController.text = widget.userReadDto?.appEmail ?? '';
      walletController.text = widget.userReadDto?.wallet?.toString() ?? '';
      bioController.text = widget.userReadDto?.bio ?? '';
      pointController.text = widget.userReadDto?.point?.toString() ?? '';
      genderController.text = widget.userReadDto?.gender ?? '';



      pickerColor = hexStringToColor(widget.userReadDto?.color ?? '#ff067e19');
      // for (int i = 0; i < listCategoryUseCase.length; i++) {
      //   final String p1 = listCategoryUseCase[i];
      //   final String p2 = widget.userReadDto?.useCase ?? '';
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
        appBar: appbar(title: s.createCategory),
        drawer: drawer(),
        body: Form(
          key: globalKey,
          child: column(
            children: <Widget>[
              textFormField(
                label: s.userName,
                onChanged: (final String value) {},
                controller: userNameController,
              ),
              textFormField(
                label: s.phoneNumber,
                onChanged: (final String value) {},
                controller: phoneNumberController,
              ),

               textFormField(
                label: s.appEmail,
                onChanged: (final String value) {},
                controller: appEmailController,
              ),

                             textFormField(
                label: s.wallet,
                onChanged: (final String value) {},
                controller: walletController,
              ),

                             textFormField(
                label: s.bio,
                onChanged: (final String value) {},
                controller: bioController,
              ),

                             textFormField(
                label: s.point,
                onChanged: (final String value) {},
                controller: pointController,
              ),

                             textFormField(
                label: s.gender,
                onChanged: (final String value) {},
                controller: genderController,
              ),


              Container(color: Colors.red, width: screenWidth, height: 200, child: listFiles(widget.userReadDto)),
              // _selectImageWeb(),
              listNewFiles(widget.userReadDto),
              _selectColor(),
              widget.userReadDto != null
                  ? button(
                      title: s.updateCategory,
                      onTap: () {
                        validateForm(
                          key: globalKey,
                          action: () {
                            updateUser(widget.userReadDto!, action: () => Get.back(result: BackResult.ok.title));
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

  // Widget _selectImageWeb() => iconTextVertical(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       leading: formLabel(s.picture),
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

  Widget listFiles(final UserReadDto? userReadDto) {
    final List<MediaReadDto> mediaList = userReadDto?.media ?? <MediaReadDto>[];
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
                listOfDeleteFile.add(mediaList[index].id );
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

  Widget listNewFiles(final UserReadDto? userReadDto) => SizedBox(
        width: screenWidth,
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listOfNewFiles.length + 1,
          itemBuilder: (final BuildContext context, final int index) {
            if (index == listOfNewFiles.length) {
              return Container(
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
                () => showFilePickerWeb(
                  action: (final PlatformFile file) {
                    listOfNewFiles.add(file);
                    listOfNewUseCase.add('file');
                    setState(() {});
                  },
                ),
              );
            } else {
              return Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.memory(listOfNewFiles[index].bytes!, width: 45, height: 45, fit: BoxFit.scaleDown),
                      ),
                      image(AppIcons.close,
                          width: 20,
                          onTap: () => setState(() {
                                listOfNewFiles.remove(listOfNewFiles[index]);
                                listOfNewUseCase.remove(listOfNewUseCase[index]);
                                useCaseMedia2.remove(useCaseMedia2[index]);
                              })),
                    ],
                  ).marginSymmetric(horizontal: 10),
                  SizedBox(
                    width: 200,
                    child: CustomAppDown(
                      selectCase: (final String selectMediaUseCase) {
                        listOfNewUseCase.removeAt(index);
                        listOfNewUseCase.insert(index, selectMediaUseCase);
                      },
                    ),
                  ),

                  // Text(mediaList[index].useCase),
                  // button(onTap: () {
                  //   listOfDeleteFile.add(mediaList[index].id ?? '');
                  //   mediaList.removeAt(index);
                  //   setState(() {
                  //
                  //   });
                  // }, title: s.delete),
                ],
              );
            }
          },
        ),
      );

  Widget _selectColor() {
    Color currentColor = hexToColor(widget.userReadDto?.color ?? "#1976D2");
    return button(
      onTap: () {
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
      },
      title: s.color,
      backgroundColor: pickerColor,
    );
  }

  Widget formLabel(final String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: context.theme.textTheme.headline6,
        ),
      );
}
