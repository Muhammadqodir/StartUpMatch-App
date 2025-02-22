import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupmatch/cubit/feed_cubit.dart';
import 'package:startupmatch/utils/dialogs.dart';
import 'package:startupmatch/widgets/loading.dart';
import 'package:startupmatch/widgets/match_widget/action_icon.dart';
import 'package:startupmatch/widgets/match_widget/card.dart';
import 'package:startupmatch/widgets/post_widget/post_widget.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MatchWidget extends StatefulWidget {
  const MatchWidget({
    super.key,
  });

  @override
  State<MatchWidget> createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {
  bool finished = false;
  MatchEngine? _matchEngine;
  List<SwipeItem> swipeItems = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await context.read<FeedCubit>().fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return finished
        ? const Center(
            child: Text("Finished"),
          )
        : BlocListener<FeedCubit, FeedState>(
            listener: (context, state) {
              if (state is FeedSuccess) {
                swipeItems = (context.read<FeedCubit>().state as FeedSuccess)
                    .getSwipeItems(
                  onLike: (id) {
                    context.read<FeedCubit>().likePitch(id);
                  },
                  onNope: (id) {
                    context.read<FeedCubit>().dislikePitch(id);
                  },
                );
                _matchEngine = MatchEngine(
                  swipeItems: swipeItems,
                );
                context.read<FeedCubit>().addView(swipeItems[0].content.id);
                setState(() {});
              }

              if (state is FeedError) {
                showAlertDialog(
                  context: context,
                  title: state.title,
                  message: state.message,
                );
              }
            },
            child: BlocBuilder<FeedCubit, FeedState>(
              builder: (ctx, state) {
                if (state is FeedSuccess) {
                  return _matchEngine != null
                      ? SwipeCards(
                          matchEngine: _matchEngine!,
                          onStackFinished: () {
                            setState(() {
                              finished = true;
                            });
                          },
                          nopeTag: const ActionIcon(
                            bgColor: Colors.red,
                            icon: CupertinoIcons.hand_thumbsdown,
                          ),
                          likeTag: const ActionIcon(
                            bgColor: Colors.green,
                            icon: CupertinoIcons.hand_thumbsup,
                          ),
                          itemChanged: (item, index) {
                            context.read<FeedCubit>().addView(item.content.id);
                            print("addView");
                          },
                          itemBuilder: (ctx, index) {
                            return EmptyCard(
                              child: PostWidget(
                                post: swipeItems[index].content,
                                matchEngine: _matchEngine!,
                              ),
                            );
                          },
                        )
                      : Expanded(
                          child: Center(
                            child: LoadingWidget(
                              title: "loading".tr(),
                            ),
                          ),
                        );
                }
                return Expanded(
                  child: Center(
                    child: LoadingWidget(
                      title: "loading".tr(),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
