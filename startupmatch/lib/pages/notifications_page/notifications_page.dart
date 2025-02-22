import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/notification.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';
import 'package:startupmatch/widgets/empty.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/loading.dart';
import 'package:startupmatch/widgets/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool showShadow = false;
  bool isLoading = false;
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    notifications = await (await getIt.getAsync<DataSource>()).getNotifications();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User me = (context.read<AuthCubit>().state as AuthorizedState).user;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 60,
              ),
              child: MyListView(
                onTop: (v) {
                  setState(() {
                    showShadow = !v;
                  });
                },
                children: isLoading
                    ? [
                        LoadingWidget(
                          title: "loading".tr(),
                        )
                      ]
                    : notifications.isNotEmpty
                        ? notifications
                            .map(
                              (e) => NotificationListItem(
                                model: e,
                              ),
                            )
                            .toList()
                        : [
                            EmptyWidget(
                              title: "notifications_is_empty".tr(),
                            )
                          ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MyAppBar(
              title: "notifications".tr(),
              backButton: true,
              showShadow: showShadow,
            ),
          ),
        ],
      ),
    );
  }
}
