import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/models/skill.dart';

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
    "https://drive.google.com/file/d/1A4HtvJNK7FY0YaaYnpCt_j0oBg6IaX2W/view?usp=sharing";

String workAdcomunidadTitle = '''Flutter Lead Developer - ADCOMUNIDAD (Spain)''';
String workAdcomunidadDate = '''Jun 2025 – Present''';
String workAdcomunidadInfo =
    '''As the Lead Developer, I take charge of the entire development and design process for cross-platform mobile apps with Flutter. My role encompasses every phase from initial architecture to product launch, including UI/UX design, building scalable and modular frameworks, developing reusable UI components, managing state with Provider and BLoC patterns, integrating REST APIs and Firebase services, and overseeing testing, CI/CD, and deployment to Google Play and App Store.''';

String workFreelance2Title = '''Freelancer - Apps Developer ''';
String workFreelance2Date = '''Oct 2024 – May 2025''';
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
  Skill(name: "Dart", percent: 0.95),
  Skill(name: "Git", percent: 0.9),
  Skill(name: "Firebase", percent: 0.75),
  Skill(name: "SCRUM", percent: 0.75),
  Skill(name: "Javascript", percent: 0.7),
  Skill(name: "Vue", percent: 0.7),
  Skill(name: "Python", percent: 0.65),
  Skill(name: "Typescript", percent: 0.65),
  Skill(name: "ReactNative", percent: 0.6),
  Skill(name: "Kotlin", percent: 0.6),
  Skill(name: "Java", percent: 0.55),

  // Habilidades Blandas (ordenadas por porcentaje)
  Skill(name: "Cooperative", percent: 0.9),
  Skill(name: "Collaborator", percent: 0.9),
  Skill(name: "Organized", percent: 0.9),
  Skill(name: "Resolutive", percent: 0.9),
  Skill(name: "Managment", percent: 0.85),
  Skill(name: "Efficient", percent: 0.85),
  Skill(name: "Proactive", percent: 0.85),
  Skill(name: "Adaptability", percent: 0.85),
];

List<Skill> languagesList = [
  Skill(name: "Spanish", percent: 1),
  Skill(name: "Galician", percent: 1),
  Skill(name: "English", percent: 0.9),
  Skill(name: "French", percent: 0.55),
];

List<Project> projectList = [
  Project(
      name: "MHWilds Assistant",
      description:
          "The Monster Hunter Assistant is a mobile application developed in Flutter that allows users to explore and discover information about monsters and decorations from the popular game Monster Hunter Wilds. The app features an intuitive interface that enables users to easily access details about the monsters, their abilities, and the game maps.",
      link: "https://github.com/Sermio/MHWilds_App",
      images: [
        "assets/images/MHWilds/1.png",
        "assets/images/MHWilds/2.png",
        "assets/images/MHWilds/3.png",
        "assets/images/MHWilds/4.png",
        "assets/images/MHWilds/5.png",
        "assets/images/MHWilds/6.png",
        "assets/images/MHWilds/7.png",
        "assets/images/MHWilds/8.png",
        "assets/images/MHWilds/9.png",
      ]),
  Project(
      name: "Missions",
      description:
          "This application consists of monitoring points of sale in different locations. The information that can be obtained is varied, such as the existence of products, prices, store organization, etc.",
      link: "https://github.com/Sermio/Missions_app",
      images: [
        "assets/images/Missions/1.png",
        "assets/images/Missions/2.png",
        "assets/images/Missions/3.png",
        "assets/images/Missions/4.png",
        "assets/images/Missions/5.png",
        "assets/images/Missions/6.png",
        "assets/images/Missions/7.png",
        "assets/images/Missions/8.png",
        "assets/images/Missions/9.png",
        "assets/images/Missions/10.png",
        "assets/images/Missions/11.png",
        "assets/images/Missions/12.png",
        "assets/images/Missions/13.png",
        "assets/images/Missions/14.png",
        "assets/images/Missions/15.png",
      ]),
  Project(
      name: "VaCar",
      description:
          "VaCar is a mobile application developed in Flutter to streamline veterinary clinic management. It enables veterinarians to manage orders, schedule appointments, and maintain detailed records of clients and pets, enhancing efficiency and simplifying operations.",
      link: "https://github.com/Sermio/VaCar",
      images: [
        "assets/images/Vacar/1.png",
        "assets/images/Vacar/2.png",
        "assets/images/Vacar/3.png",
        "assets/images/Vacar/4.png",
        "assets/images/Vacar/5.png",
        "assets/images/Vacar/6.png",
        "assets/images/Vacar/7.png",
        "assets/images/Vacar/8.png",
        "assets/images/Vacar/9.png",
        "assets/images/Vacar/10.png",
        "assets/images/Vacar/11.png",
      ]),
  Project(
      name: "Monster Hunter",
      description:
          "The Monster Hunter is a mobile application developed in Flutter that allows users to explore and discover information about monsters and decorations from the popular game Monster Hunter. The app features an intuitive interface that enables users to easily access details about the monsters, their abilities, and the game maps. ",
      link: "https://github.com/Sermio/MH_app",
      images: [
        "assets/images/MHW/1.png",
        "assets/images/MHW/2.png",
        "assets/images/MHW/3.png",
        "assets/images/MHW/4.png",
        "assets/images/MHW/5.png",
        "assets/images/MHW/6.png",
      ]),
  Project(
      name: "WorldShift",
      description:
          "The WorldShift Tribute Application is a tribute to the game WorldShift (2008), designed as a comprehensive interactive catalog of in-game items. It offers users an intuitive way to browse, search, and filter through a vast collection of equipment. With a strong emphasis on accuracy and usability, it allows for detailed item exploration, making it an invaluable tool for both casual players and dedicated strategists.",
      link: "https://github.com/Sermio/WD_filter",
      images: [
        "assets/images/Worldshift/1.png",
        "assets/images/Worldshift/2.png",
        "assets/images/Worldshift/3.png",
        "assets/images/Worldshift/4.png",
      ]),
  Project(
      name: "Diseños",
      description:
          "A mobile app that demonstrates a variety of custom UI designs and animations. This app serves as a showcase of different layouts and UI components like slideshows, list views, custom headers, custom progress bars, and more. Perfect for developers looking for inspiration or trying to implement similar designs in their own apps.",
      link: "https://github.com/Sermio/disenos_app",
      images: [
        "assets/images/Disenos/1.png",
        "assets/images/Disenos/2.png",
        "assets/images/Disenos/3.png",
        "assets/images/Disenos/4.png",
        "assets/images/Disenos/5.png",
        "assets/images/Disenos/6.png",
      ]),
  Project(
      name: "QR scanner",
      description:
          "This app allows users to scan QR codes quickly and efficiently. By using the camera on a mobile device, the app can detect and interpret QR codes, providing users with the possibility to send encoded data from the QR code to a backend. The app features an intuitive interface, with easy-to-use functionality for both beginners and advanced users. It also ensures security and privacy by not storing or sharing scanned information without user consent.",
      link: "https://github.com/Sermio/QR_scan",
      images: [
        "assets/images/QRScan/1.png",
        "assets/images/QRScan/2.png",
        "assets/images/QRScan/3.png",
        "assets/images/QRScan/4.png",
        "assets/images/QRScan/5.png",
      ]),
  Project(
      name: "Subasta Forestal",
      description:
          "The Subasta Forestal application is an intuitive technology platform designed for those interested in buying or selling wood. The visual design of the app was provided by the client to be followed accordingly.\n This application is aimed at both PROPERTY OWNERS (individuals and forestry communities) and BUYERS (self-employed individuals and companies).",
      link: "https://github.com/Sermio/Subasta_forestal",
      images: [
        "assets/images/SubastaForestal/1.png",
        "assets/images/SubastaForestal/2.png",
        "assets/images/SubastaForestal/3.png",
        "assets/images/SubastaForestal/4.png",
      ]),
  Project(
      name: "Shoes",
      description:
          "A mobile app that allows users to view a product with the option to select different colors and interactive animations to enhance the user experience.",
      link: "https://github.com/Sermio/ShoesApp",
      images: [
        "assets/images/Shoes/1.png",
        "assets/images/Shoes/2.png",
      ]),
  Project(
      name: "Music Player",
      description:
          "Music player app with animated visualizations, an intuitive interface, and responsive design, built with Flutter and state managed using Provider.",
      link: "https://github.com/Sermio/music_player",
      images: [
        "assets/images/MusicPlayer/1.png",
      ]),
];
