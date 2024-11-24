import 'package:flutter/material.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/widgets/buttons/flat_button.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({
    super.key,
    required this.user,
    this.isList = false,
    this.showFollow = true,
    this.margin = const EdgeInsets.all(0),
  });
  final User user;
  final bool isList;
  final bool showFollow;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              user.pic,
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isList
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            fontWeight: FontWeight.w900,
                          ),
                ),
                Text(
                  user.username,
                  style: isList
                      ? Theme.of(context).textTheme.titleSmall
                      : Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ],
            ),
          ),
          if (showFollow)
            SizedBox(
              width: 100,
              height: 60,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                title: "Follow",
                onTap: () {},
              ),
            ),
        ],
      ),
    );
  }
}

class ExpandDescription extends StatefulWidget {
  const ExpandDescription({
    super.key,
    required this.text,
    this.lines = 2,
  });
  final String text;
  final int lines;

  @override
  State<ExpandDescription> createState() => _ExpandDescriptionState();
}

class _ExpandDescriptionState extends State<ExpandDescription> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          showDragHandle: true,
          context: context,
          builder: (context) => Column(
            children: [
              Text(widget.text),
            ],
          ),
        );
      },
      child: Text(
        widget.text,
        maxLines: widget.lines,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
