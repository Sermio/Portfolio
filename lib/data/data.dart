import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/models/skill.dart';
import 'package:url_launcher/url_launcher.dart';

//Update with colors of your choice for dp background gradient
Color kGradient1 = Colors.blue.shade900;
Color kGradient2 = Colors.cyan;
// Color kGradient1 = Colors.purple;
// Color kGradient2 = Colors.pinkAccent;

String imagePath = "images/aditya.jpeg";

//String data to modify
String name = "Sergio Miguel Trabajo";
String username = "flutterroles";

//Link to resume on Google Drive
String resumeLink =
    "https://drive.google.com/file/d/19pDgAC_BBFeyyeuuk1i94uNGkr71OR2M/view?usp=sharing";

String workFreelance2Title = '''Freelancer - Apps Developer ''';
String workFreelance2Date = '''Oct 2024 – Present''';
String workFreelance2Info =
    '''Design and development of cross-platform (Android and iOS) apps using Flutter and Kotlin.''';

String workSoteloTitle =
    '''Software Engineer and Consultant - Sotelo S.L. (Spain)''';
String workSoteloDate = '''May 2022 – Oct. 2024''';
String workSoteloInfo =
    '''I worked in a multidisciplinary team, where I learned Vue.js, Python, React Native, and SCRUM. This position also allowed me to develop strong skills in team management, project coordination and customer communication.''';

String workFreelanceTitle = '''Freelance - Flutter Apps Developer''';
String workFreelanceDate = '''Feb. 2022 – Apr. 2022''';
String workFreelanceInfo =
    '''I developed and released the "Subasta Forestal" app using Flutter, with over 500 downloads. I responsible for the updates of "SBC Gasolineras" and "Museo das Peregrinacións" apps in Native Java/Kotlin.''';

String workInternshipTitle =
    '''Internship as Flutter Developer - Servicios Reunidos S.L. (Spain)''';
String workInternshipDate = '''Sep. 2020 – Feb. 2022''';
String workInternshipInfo =
    '''As part of my Bachelor’s Thesis, I developed a Flutter app capable of extracting information from pictures using a neural network. It had also a website development in Vue.js''';

String aboutMeSummary = '''
I am a Graduate in Computer Engineering with experience in both freelance and corporate development. I have worked both in teams and independently, acquiring skills in coordination, communication, and client management.

I am eager to improve my skills in front-end development and contribute to innovative projects within a dynamic and productive corporate environment. ''';

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
  Skill(name: "Firebase", percent: 0.75),
  Skill(name: "Firebase", percent: 0.65),
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
  Skill(name: "Efficient", percent: 0.8),
  Skill(name: "Proactive", percent: 0.8),
  Skill(name: "Adaptability", percent: 0.8),
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
