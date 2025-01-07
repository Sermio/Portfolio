import 'package:flutter/material.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/components/skills_section.dart';
import 'package:portfolio/data/data.dart';

class MainSections extends StatelessWidget {
  const MainSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience",
          style: kSectionTitleText,
        ),
        const SizedBox(
          height: 10,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isSmallScreen = constraints.maxWidth <= 600;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallScreen)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workFreelance2Title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workFreelance2Date,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workFreelance2Title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workFreelance2Date,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ],
              );
            },
          ),
        ),
        Text(workFreelance2Info),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isSmallScreen = constraints.maxWidth <= 600;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallScreen)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workSoteloTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workSoteloDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workSoteloTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workSoteloDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ],
              );
            },
          ),
        ),
        Text(workSoteloInfo),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isSmallScreen = constraints.maxWidth <= 600;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallScreen)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workFreelanceTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workFreelanceDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workFreelanceTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workFreelanceDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ],
              );
            },
          ),
        ),
        Text(workFreelanceInfo),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isSmallScreen = constraints.maxWidth <= 600;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallScreen)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workInternshipTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workInternshipDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workInternshipTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workInternshipDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ],
              );
            },
          ),
        ),
        Text(workInternshipInfo),

        const Divider(),
        Text("About Me", style: kSectionTitleText),
        const SizedBox(
          height: 10,
        ),
        Text(aboutMeSummary),
        const Divider(),
        Text("My Skills", style: kSectionTitleText),
        const SizedBox(
          height: 10,
        ),
        //skills
        //skillsSection
        SkillsSection(skills: skillsList),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
