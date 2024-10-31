// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/tap_scale.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({
    Key? key,
    required this.items,
    this.hint = "",
    required this.onChange,
    this.baseColor = const Color(0xFFF7F8F8),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
    this.margin = const EdgeInsets.all(12),
    this.color = primaryColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);
  final List<String> items;
  final String hint;
  final Function onChange;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final Color color;
  final Color baseColor;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.baseColor,
        borderRadius: widget.borderRadius,
      ),
      child: Row(
        children: widget.items
            .map(
              (e) => Expanded(
                child: OnTapScaleAndFade(
                  lowerBound: 0.95,
                  child: Container(
                    alignment: Alignment.center,
                    padding: widget.padding,
                    decoration: BoxDecoration(
                      color: widget.items.indexOf(e) == selectedItem
                          ? widget.color
                          : widget.baseColor,
                      borderRadius: widget.borderRadius,
                    ),
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: widget.items.indexOf(e) == selectedItem
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedItem = widget.items.indexOf(e);
                    });
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
