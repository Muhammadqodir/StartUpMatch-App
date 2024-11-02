import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:startupmatch/models/pitch.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/widgets/icon_button.dart';
import 'package:startupmatch/widgets/tap_scale.dart';

class Pitch extends StatefulWidget {
  const Pitch({
    super.key,
    required this.model,
  });

  final PitchModel model;

  @override
  State<Pitch> createState() => _PitchState();
}

class _PitchState extends State<Pitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              widget.model.videoUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 60,
            left: 12,
            right: 50,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserTitle(user: widget.model.owner),
                  const SizedBox(height: 6),
                  ExpandDescription(text: widget.model.description)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            right: 12,
            child: SafeArea(
              child: Column(
                children: [
                  ActionWidget(
                    onTap: () {},
                    icon: CupertinoIcons.hand_thumbsup,
                    title: widget.model.likes.length.toString(),
                  ),
                  const SizedBox(height: 24),
                  ActionWidget(
                    onTap: () {},
                    icon: CupertinoIcons.hand_thumbsdown,
                    title: widget.model.likes.length.toString(),
                  ),
                  const SizedBox(height: 24),
                  ActionWidget(
                    onTap: () {},
                    icon: CupertinoIcons.chat_bubble,
                    title: widget.model.comments.length.toString(),
                  ),
                  const SizedBox(height: 24),
                  ActionWidget(
                    onTap: () {},
                    icon: CupertinoIcons.ellipsis_vertical,
                    title: "",
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ActionWidget extends StatelessWidget {
  const ActionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final Function onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.9),
                spreadRadius: 1,
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          if (title != "")
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            )
        ],
      ),
      onTap: () {
        onTap();
      },
    );
  }
}

class UserTitle extends StatelessWidget {
  const UserTitle({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return Row(
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
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        spreadRadius: 1,
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    fontWeight: FontWeight.w900),
              ),
              Text(
                user.username,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        spreadRadius: 1,
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandDescription extends StatefulWidget {
  const ExpandDescription({super.key, required this.text});
  final String text;

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
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
