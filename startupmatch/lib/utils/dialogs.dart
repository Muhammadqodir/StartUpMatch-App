import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
void showSelectWeekDialog({
  required BuildContext context,
  required int initialItem,
  required List<String> items,
  required Function(int) action,
}) {
  FixedExtentScrollController extentScrollController =
      FixedExtentScrollController(initialItem: initialItem);
  int selected = 0;
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: 250,
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
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: CupertinoPicker(
                scrollController: extentScrollController,
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: false,
                looping: false,
                itemExtent: 32,
                // This is called when selected item is changed.
                onSelectedItemChanged: (int selectedItem) {
                  SystemSound.play(SystemSoundType.click);
                  HapticFeedback.mediumImpact();
                  selected = selectedItem;
                },
                children: List<Widget>.generate(
                  items.length,
                  (int index) {
                    return Center(
                      child: Text(
                        items[index],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
              ),
            ),
            CupertinoButton(
              child: Text(
                "Выбрать",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () {
                Navigator.pop(context);
                action(selected);
              },
            )
          ],
        ),
      ),
    ),
  );
}

void showConfirmDialog(BuildContext context, String title, String msg,
    void Function() confirmAction) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        msg,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () {
            Navigator.pop(context);
            confirmAction();
          },
          child: Text(
            "confirm".tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "cancel".tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    ),
  );
}

void showUpdateDialog(BuildContext context, String version) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text(
        "Обновление",
      ),
      content: Text(
        "Доступно новая версия $version. Обновите приложение!",
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () {
            // OpenStore.instance.open(
            //   appStoreId: '1644613830',
            //   androidAppBundleId: 'uz.mqsoft.ecampusncfu',
            // );
          },
          child: const Text(
            "Обновить",
          ),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Позже",
          ),
        )
      ],
    ),
  );
}

void showOfflineDialog(BuildContext context, Function retry) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        "no_connection".tr(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        "no_connection_desc".tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            retry();
          },
          child: Text(
            "retry".tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => const CupertinoAlertDialog(
      title: Text("Yuklanmoqda"),
      content: Center(
        child: Column(children: [
          SizedBox(
            height: 12,
          ),
          CupertinoActivityIndicator(
            radius: 12,
          )
        ]),
      ),
    ),
  );
}

Future<void> showAlertDialog(
  BuildContext context,
  String title,
  String message,
) async {
  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "ok".tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}