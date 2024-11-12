import 'package:flutter/material.dart';
import 'package:portfolio/components/header.dart';
import 'package:portfolio/components/main_content.dart';
import 'package:portfolio/components/projects_list.dart';
import 'package:portfolio/components/resume_contact_buttons.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Row(
      //     children: [
      //       Icon(
      //         Icons.circle_sharp,
      //         size: 12,
      //         color: Colors.black,
      //       ),
      //       SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         "Sergio Miguel Trabajo",
      //         style: TextStyle(color: Colors.black),
      //       )
      //     ],
      //   ),
      //   // foregroundColor: Colors.black,
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WebHeader(),
            Center(
                child: Text(
              name,
              style: kTitleText,
            )),
            // Center(
            //     child: Text(
            //   "@$username",
            //   style: kSubTitleText,
            // )),
            const SizedBox(
              height: 10,
            ),
            const ResumeContactButtons(),
            const SizedBox(
              height: 10,
            ),
            const MainContent(),
            const ProjectsList(),
          ],
        ),
      ),
    );
  }
}
