import 'package:flutter/material.dart';
import 'package:portfolio/components/skills_section.dart';

import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';
import 'package:url_launcher/url_launcher.dart';

class References extends StatelessWidget {
  const References({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
            // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Location",
                style: kSubTitleText,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    location,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Website",
                style: kSubTitleText,
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Row(
                children: [
                  Text(github),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () async {
                        if (await canLaunchUrl(githubUrl)) {
                          await launchUrl(githubUrl);
                        } else {
                          throw 'Could not launch $githubUrl';
                        }
                      },
                      icon: const Icon(Icons.link)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Linkedin",
                style: kSubTitleText,
              ),
              Row(
                children: [
                  Text(linkedin),
                  IconButton(
                      onPressed: () async {
                        if (await canLaunchUrl(githubUrl)) {
                          await launchUrl(githubUrl);
                        } else {
                          throw 'Could not launch $githubUrl';
                        }
                      },
                      icon: const Icon(Icons.link)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: kSubTitleText,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(email),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Telephone",
                style: kSubTitleText,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(phone),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Languages",
                style: kSubTitleText,
              ),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                children: [
                  SkillsSection(skills: languagesList),
                ],
              ),
            ]),
          ),
        )
      ],
    );
  }
}
