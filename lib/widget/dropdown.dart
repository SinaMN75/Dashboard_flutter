import 'package:dashboard/core/core.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class AppDropDown<T> extends StatefulWidget {
  const AppDropDown({
    required this.onChange,
    required this.value,
    required this.items,
    this.icon,
    this.title,
    final Key? key,
  }) : super(key: key);

  final T value;
  final List<DropdownMenuItem<T>>? items;
  final Function(T) onChange;
  final Widget? icon;
  final String? title;

  @override
  _AppDropDownState<T> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  T? _currentItem;

  @override
  Widget build(final BuildContext context) {
    _currentItem = widget.value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.title == null ? const SizedBox() : Text(widget.title ?? '').subtitle2().marginOnly(bottom: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.backgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: context.theme.dividerColor),
            ),
            child: DropdownButton<T>(
              value: _currentItem,
              icon: image(AppIcons.expansionArrow),
              iconSize: 30,
              elevation: 16,
              style: context.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500),
              isExpanded: true,
              underline: const SizedBox(),
              onChanged: (final T? newValue) {
                setState(() {
                  _currentItem = newValue;
                  widget.onChange(newValue as T);
                });
              },
              items: widget.items,
            ).marginSymmetric(vertical: 2, horizontal: 10),
          ),


        ],
      ),
    );
  }
}
