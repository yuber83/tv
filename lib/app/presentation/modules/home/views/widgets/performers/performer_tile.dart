import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/performer/performer.dart';
import '../../../../../global/utils/get_image_url.dart';

class PerformerTile extends StatelessWidget {
  const PerformerTile({super.key, required this.performer});
  final Performer performer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned.fill(
              child: ExtendedImage.network(
                getImageUrl(
                  performer.profilePath,
                  imageQuality: ImageQuality.original,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      performer.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (performer.name != performer.originalName)
                      Text(
                        performer.originalName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
