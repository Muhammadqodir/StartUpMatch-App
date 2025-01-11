import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';
import 'package:startupmatch/widgets/card.dart';
import 'package:startupmatch/widgets/post_widget/inc.dart';

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
      onTap: () {},
      child: MyCard(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTitle(
              user: widget.pitch.owner,
              isList: true,
              showFollow: false,
            ),
            const SizedBox(height: 6),
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
            const SizedBox(width: 12),
            Text(
              widget.pitch.description,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyIconButton(
                  width: 24,
                  height: 24,
                  onTap: () {},
                  child: Icon(CupertinoIcons.heart),
                ),
                Text(
                  "12",
                  style: Theme.of(context).textTheme.bodyMedium,
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
