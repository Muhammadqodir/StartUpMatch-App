import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/utils/dialogs.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';
import 'package:startupmatch/widgets/card.dart';
import 'package:startupmatch/widgets/post_widget/inc.dart';
import 'package:startupmatch/widgets/post_widget/fullscrean_video_player.dart';

class PitchCard extends StatefulWidget {
  const PitchCard({
    super.key,
    required this.pitch,
  });

  final PitchModel pitch;

  @override
  State<PitchCard> createState() => _PitchCardState();
}

class _PitchCardState extends State<PitchCard> {
  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      lowerBound: 0.97,
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => FullScreanVideoPlayer(
              videoUrl: widget.pitch.getVideoUrl(),
              title: widget.pitch.title,
            ),
          ),
        );
      },
      onLongPress: () {
        showBottomContextDialog(context, widget.pitch);
      },
      child: MyCard(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTitle(
              user: widget.pitch.owner,
              isList: true,
            ),
            const SizedBox(height: 12),
            Text(
              widget.pitch.description,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    "https://sandbox.alfocus.uz/startup-match/getVideoCover.php?url=${Uri.encodeQueryComponent(
                      widget.pitch.getVideoUrl(),
                    )}",
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const SizedBox(
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/video_placeholder.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      );
                    },
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Icon(
                      CupertinoIcons.play_circle_fill,
                      color: Colors.white,
                      size: 48,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 2),
                const Icon(
                  CupertinoIcons.eye,
                  size: 16,
                ),
                const SizedBox(width: 3),
                Text(
                  widget.pitch.views.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 12),
                const Icon(
                  CupertinoIcons.hand_thumbsup,
                  size: 16,
                ),
                const SizedBox(width: 3),
                Text(
                  widget.pitch.likes.length.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 12),
                const Icon(
                  CupertinoIcons.hand_thumbsdown,
                  size: 16,
                ),
                const SizedBox(width: 3),
                Text(
                  widget.pitch.dislikes.length.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(child: SizedBox()),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    widget.pitch.getShortTime(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
