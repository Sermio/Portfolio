import 'package:flutter/material.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/screens/widgets/project_widget.dart';
import 'package:portfolio/utils/extensions.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = context.screenConstraint().width;

    int crossAxisCount = screenWidth > 900 ? 2 : 1;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.8,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: screenWidth > 1780 ? 5 : 3,
          ),
          itemCount: projectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ProjectWidget(
              projectData: projectList[index],
            );
          },
        ),
      ),
    );
  }
}
