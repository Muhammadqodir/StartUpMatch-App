import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFBAE8F9),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/ic_launcher.png",
                  image:
                      "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg",
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/ic_launcher.png"),
                ),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "user.name",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "user.email",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            OnTapScaleAndFade(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                child: const Icon(
                  CupertinoIcons.pen,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 18,
            ),
            const SizedBox(width: 1),
            Text(
              "Stavropol",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 12),
            const Icon(
              CupertinoIcons.calendar,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              "Joined May 2022",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "lorem",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
