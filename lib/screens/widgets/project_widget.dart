import 'package:flutter/material.dart';
import 'package:portfolio/components/slideshow.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/project_model.dart';

class ProjectWidget extends StatelessWidget {
  final Project projectData;
  const ProjectWidget({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int maxLines;

    if (screenWidth <= 410) {
      maxLines = 1;
    } else if ((screenWidth >= 400) && (screenWidth <= 550)) {
      maxLines = 1;
    } else if (screenWidth >= 900 && screenWidth <= 1050) {
      maxLines = 3;
    } else if (screenWidth <= 1200) {
      maxLines = 4;
    } else {
      maxLines = 6;
    }

    return SizedBox(
      width: context.screenConstraint().width * 0.4,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.build,
                  //   color: kGrey,
                  //   size: 18,
                  // ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      projectData.name,
                      style: kSectionTitleText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(projectData.link);
                        await launchUrl(url);
                      },
                      child: Text(
                        "View",
                        style: kSubTitleText.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                ),
                child: Text(
                  projectData.description,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            // Slideshow(slides: [
            //   Image.network(
            //       'https://github.com/user-attachments/assets/82dcfb2b-90e1-458d-8e44-6a9a4695cd82')
            // ])
          ],
        ),
      ),
    );
  }
}
