import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/screens/widgets/project_widget.dart';
import 'package:portfolio/utils/extensions.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = context.screenConstraint().width;

    int crossAxisCount = screenWidth > 1010 ? 2 : 1;

    double aspectRatio = screenWidth > 510 ? 1.6 : 1.3;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.8,
        child: GridView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (aspectRatio - 0.3),
          ),
          itemCount: projectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ProjectWidget(
              project: projectList[index],
            );
          },
        ),
      ),
    );
  }
}
