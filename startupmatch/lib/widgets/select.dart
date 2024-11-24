import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

const double _kItemExtent = 32.0;

class CustomSelect extends StatefulWidget {
  final String hint;
  final TextAlign textAlign;
  final BorderRadius borderRadius;
  final IconData icon;
  final List<String> items;
  final Function(int) onChanged;
  final Color baseColor;
  final EdgeInsets padding;
  final String title;
  final EdgeInsets margin;

  const CustomSelect({
    this.hint = "",
    required this.items,
    required this.title,
    required this.onChanged,
    this.baseColor = const Color(0xFFF7F8F8),
    this.textAlign = TextAlign.start,
    required this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
    this.margin = const EdgeInsets.all(12),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  Color currentColor = Colors.black12;

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    currentColor = widget.baseColor;
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      lowerBound: 0.95,
      onTap: () {
        if (widget.items.isNotEmpty) {
          showSelectDialog();
        }
      },
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.baseColor,
          borderRadius: widget.borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Icon(
                widget.icon,
                color: Colors.black54,
                size: 22,
              ),
              const SizedBox(
                width: 12,
              ),
              selectedIndex < 0
                  ? Expanded(
                      child: Text(
                        widget.hint,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .color!
                                  .withAlpha(160),
                            ),
                      ),
                    )
                  : Expanded(
                      child: Text(
                        widget.items[selectedIndex],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ),
              const SizedBox(
                width: 12,
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                color: Colors.black54,
                size: 22,
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSelectDialog() {
    FixedExtentScrollController extentScrollController =
        FixedExtentScrollController(
            initialItem: selectedIndex < 0 ? 0 : selectedIndex);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 252,
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 150,
                  child: CupertinoPicker(
                    scrollController: extentScrollController,
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: false,
                    looping: false,
                    itemExtent: _kItemExtent,
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      SystemSound.play(SystemSoundType.click);
                      HapticFeedback.mediumImpact();
                    },
                    children:
                        List<Widget>.generate(widget.items.length, (int index) {
                      return Center(
                        child: Text(
                          widget.items[index],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }),
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    "select".tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = extentScrollController.selectedItem;
                    });
                    widget.onChanged(selectedIndex);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
