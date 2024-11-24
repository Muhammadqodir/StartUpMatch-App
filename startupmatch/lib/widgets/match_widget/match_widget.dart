import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/feed_cubit.dart';
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
    swipeItems = context.read<FeedCubit>().state.getSwipeItems();
    _matchEngine = MatchEngine(
      swipeItems: swipeItems,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return finished
        ? const Center(
            child: Text("Finished"),
          )
        : BlocBuilder<FeedCubit, FeedState>(
            builder: (ctx, state) {
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
                      itemChanged: (item, index) {},
                      itemBuilder: (ctx, index) {
                        return EmptyCard(
                          child: PostWidget(
                            post: swipeItems[index].content,
                            matchEngine: _matchEngine!,
                          ),
                        );
                      },
                    )
                  : const SizedBox();
            },
          );
  }
}
