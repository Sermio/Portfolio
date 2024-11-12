import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/models/skill.dart';
import 'package:url_launcher/url_launcher.dart';

//Update with colors of your choice for dp background gradient
Color kGradient1 = Colors.blue.shade900;
Color kGradient2 = Colors.cyan;
// Color kGradient1 = Colors.purple;
// Color kGradient2 = Colors.pinkAccent;

String imagePath = "images/img.png";

//String data to modify
String name = "Sergio Miguel";
String username = "flutterroles";

//Link to resume on Google Drive
String resumeLink =
    "https://drive.google.com/file/d/1m43OglFcd4QVRFr4YcfwUwcurmwSVHsZ/view?usp=sharing";

String workSoteloTitle = '''Junior Software Developer - Sotelo S.L. (Spain)''';
String workSoteloDate = '''May 2022 – Oct. 2024''';
String workSoteloInfo =
    '''I worked in a multidisciplinary team with whom I have learned Vue.js, Python, React Native, and SCRUM. I have gained experience managing teams, coordinating projects and communicating with customers.''';

String workFreelanceTitle = '''Freelancer''';
String workFreelanceDate = '''Feb. 2022 – Apr. 2022''';
String workFreelanceInfo =
    '''I developed the "Subasta Forestal" app using Flutter, managing its launch and updates on Google Play Store, with over 500 downloads. I also contributed to updates for the "SBC Gasolineras" and "Museo das Peregrinacións" apps in Native Java, enhancing fuel services and improving user interactivity within the museum.''';

String workInternshipTitle = '''Internship - Servicios Reunidos S.L. (Spain)''';
String workInternshipDate = '''Sep. 2020 – Feb. 2022''';
String workInternshipInfo =
    '''As part of my bachelor’s thesis, I developed a Flutter application capable of extracting information from pictures using a neural network. It had also a website component in Vue.js.''';

String aboutMeSummary = '''
I have a degree in Computer Engineering and over the past few years I have gained experience working as a freelancer and for different companies. I have worked with a team of people carrying out projects for multiple clients, which has taught me how to coordinate tasks, communicate clearly to convey problems and needs and handle customers in different languages. I have also worked on individual projects where I have learned to be autonomous, prioritize and meet deadlines.

My professional goal is to work in front-end applications, especially in mobile. I am eager to learn, to continue improving my knowledge and I am motivated to participate in new projects to put my skills into practice.
''';

String location = "A Coruña (Spain)";
String github = "My GitHub";
Uri githubUrl = Uri.parse("https://github.com/Sermio");
String linkedin = "/sergio-miguel-trabajo";
Uri linkedinUrl =
    Uri.parse("https://www.linkedin.com/in/sergio-miguel-trabajo/");
String email = "sergiomt97@gmail.com";
String phone = "+34 606683231";

List<Skill> skillsList = [
  // Habilidades Técnicas (ordenadas por porcentaje)
  Skill(name: "Flutter", percent: 0.95),
  Skill(name: "Dart", percent: 0.9),
  Skill(name: "Git", percent: 0.85),
  Skill(name: "SCRUM", percent: 0.85),
  Skill(name: "Vue", percent: 0.75),
  Skill(name: "Javascript", percent: 0.7),
  Skill(name: "Python", percent: 0.7),
  Skill(name: "Typescript", percent: 0.65),
  Skill(name: "ReactNative", percent: 0.65),
  Skill(name: "Java", percent: 0.6),
  Skill(name: "Kotlin", percent: 0.6),

  // Habilidades Blandas (ordenadas por porcentaje)
  Skill(name: "Cooperative", percent: 0.9),
  Skill(name: "Collaborator", percent: 0.9),
  Skill(name: "Resolutive", percent: 0.85),
  Skill(name: "Organized", percent: 0.9),
  Skill(name: "Managment", percent: 0.8),
];

List<Skill> languagesList = [
  Skill(name: "Spanish", percent: 1),
  Skill(name: "Galician", percent: 1),
  Skill(name: "English", percent: 0.9),
  Skill(name: "French", percent: 0.55),
];

List<Project> projectList = [
  Project(
      name: "Monster Hunter App",
      description:
          "The Monster Hunter App is a mobile application developed in Flutter that allows users to explore and discover information about monsters and decorations from the popular game Monster Hunter. The app features an intuitive interface that enables users to easily access details about the monsters, their abilities, and the game maps. ",
      link: "https://github.com/Sermio/MH_app"),
  Project(
      name: "Subasta Forestal",
      description:
          "The Subasta Forestal application is an intuitive technology platform designed for those interested in buying or selling wood. The visual design of the app was provided by the client to be followed accordingly.\n This application is aimed at both PROPERTY OWNERS (individuals and forestry communities) and BUYERS (self-employed individuals and companies).",
      link: "https://github.com/Sermio/Subasta_forestal"),
  Project(
      name: "Missions App",
      description:
          "This application consists of monitoring points of sale in different locations. The information that can be obtained is varied, such as the existence of products, prices, store organization, etc.",
      link: "https://github.com/Sermio/Missions_app"),
];
