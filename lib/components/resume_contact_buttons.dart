import 'package:flutter/material.dart';

import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';

import 'package:url_launcher/url_launcher.dart';

class ResumeContactButtons extends StatelessWidget {
  const ResumeContactButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () async {
              final Uri url = Uri.parse(resumeLink);
              await launchUrl(url);
            },
            child: Text(
              "View Resume",
              style: kSubTitleText,
            )),
        // const SizedBox(
        //   width: 10,
        // ),
        // ElevatedButton(
        //     onPressed: () async {
        //       //Call to launch email
        //       final Uri emailLaunchUri = Uri(
        //         scheme: 'mailto',
        //         path: contactEmail,
        //       );
        //       await launchUrl(emailLaunchUri);
        //     },
        //     child: Row(
        //       children: [
        //         const Icon(
        //           Icons.add,
        //           size: 16,
        //           color: Colors.white,
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Text(
        //           "Contact",
        //           style: kSubTitleText.copyWith(color: Colors.white),
        //         )
        //       ],
        //     ))
      ],
    );
  }
}
