import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/models/skill.dart';

// Personal info
const name = "Sergio Miguel Trabajo";
const firstName = "Sergio";
const role = "Flutter Lead Developer";
const location = "A Coruña, Spain";
const heroHeadlineStart = "I build cross-platform apps with ";
const heroHeadlineHighlight = "Flutter";
const heroSubtitle =
    "Computer Engineer leading mobile products end to end: architecture, UI/UX, Firebase, testing and releases to Google Play and the App Store.";
const avatarAsset = "assets/images/img.png";

/// Start of my professional career, used for the "years of experience" stat.
final careerStart = DateTime(2020, 9);

const email = "sergiomt97@gmail.com";
const phone = "+34 606683231";
const linkedinHandle = "/sergio-miguel-trabajo";
const githubHandle = "Sermio";
final emailUri = Uri(scheme: 'mailto', path: email);
final phoneUri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
final githubUri = Uri.parse("https://github.com/Sermio");
final linkedinUri =
    Uri.parse("https://www.linkedin.com/in/sergio-miguel-trabajo/");

/// Resume on Google Drive.
final resumeUri = Uri.parse(
    "https://drive.google.com/file/d/1A4HtvJNK7FY0YaaYnpCt_j0oBg6IaX2W/view?usp=sharing");

const aboutMeParagraphs = [
  "I am a Graduate in Computer Engineering with experience in both freelance and corporate development. I have worked both in teams and independently, acquiring skills in coordination, communication, and client management.",
  "I am eager to improve my skills in front-end development and contribute to innovative projects within a dynamic and productive corporate environment.",
];

const experienceList = [
  Experience(
    role: "Flutter Lead Developer",
    company: "ADCOMUNIDAD · Spain",
    period: "Jun 2025 – Present",
    description:
        "As the Lead Developer, I take charge of the entire development and design process for cross-platform mobile apps with Flutter. My role encompasses every phase from initial architecture to product launch, including UI/UX design, building scalable and modular frameworks, developing reusable UI components, managing state with Provider and BLoC patterns, integrating REST APIs and Firebase services, and overseeing testing, CI/CD, and deployment to Google Play and App Store.",
  ),
  Experience(
    role: "Apps Developer",
    company: "Freelance",
    period: "Oct 2024 – May 2025",
    description:
        "Design and development of cross-platform (Android and iOS) apps using Flutter and Kotlin.",
  ),
  Experience(
    role: "Software Engineer and Consultant",
    company: "Sotelo S.L. · Spain",
    period: "May 2022 – Oct 2024",
    description:
        "I worked in a multidisciplinary team, where I learned Vue.js, Python, React Native, and SCRUM. This position also allowed me to develop strong skills in team management, project coordination and customer communication.",
  ),
  Experience(
    role: "Flutter Apps Developer",
    company: "Freelance",
    period: "Feb 2022 – Apr 2022",
    description:
        "I developed and released the \"Subasta Forestal\" app using Flutter, with over 500 downloads. I was responsible for the updates of the \"SBC Gasolineras\" and \"Museo das Peregrinacións\" apps in native Java/Kotlin.",
  ),
  Experience(
    role: "Flutter Developer (Internship)",
    company: "Servicios Reunidos S.L. · Spain",
    period: "Sep 2020 – Feb 2022",
    description:
        "As part of my Bachelor’s Thesis, I developed a Flutter app capable of extracting information from pictures using a neural network. It also had a website developed in Vue.js.",
  ),
];

const techSkills = [
  Skill(name: "Flutter", percent: 0.95),
  Skill(name: "Dart", percent: 0.95),
  Skill(name: "Git", percent: 0.9),
  Skill(name: "Firebase", percent: 0.75),
  Skill(name: "SCRUM", percent: 0.75),
  Skill(name: "JavaScript", percent: 0.7),
  Skill(name: "Vue", percent: 0.7),
  Skill(name: "Python", percent: 0.65),
  Skill(name: "TypeScript", percent: 0.65),
  Skill(name: "React Native", percent: 0.6),
  Skill(name: "Kotlin", percent: 0.6),
  Skill(name: "Java", percent: 0.55),
];

const softSkills = [
  "Cooperative",
  "Collaborative",
  "Organized",
  "Resolutive",
  "Management",
  "Efficient",
  "Proactive",
  "Adaptable",
];

const languagesList = [
  Skill(name: "Spanish", percent: 1),
  Skill(name: "Galician", percent: 1),
  Skill(name: "English", percent: 0.9),
  Skill(name: "French", percent: 0.55),
];

/// Technologies detected in project descriptions. They feed the project
/// filter chips and the tags shown on each card.
const projectTechnologies = [
  "Flutter",
  "Firebase",
  "Riverpod",
  "Provider",
  "Flame",
  "Gemini",
  "SQLite",
  "Arduino",
  "Kotlin",
  "Java",
  "Vue",
  "Python",
  "React Native",
];

/// Screenshot paths `assets/images/<folder>/1.jpg … <count>.jpg`.
List<String> _screenshots(String folder, int count, {String ext = "jpg"}) =>
    [for (var i = 1; i <= count; i++) "assets/images/$folder/$i.$ext"];

final projectList = <Project>[
  Project(
      name: "VaCar",
      description:
          "Multi-tenant SaaS built with Flutter and Firebase for livestock veterinary clinics. Office staff create field work orders, vets mark when they are on the way, complete visits with notes and treatments, collect on-screen signatures and generate PDF invoices and delivery notes. Includes a team chat with voice notes, push notifications with Cloud Functions, roles via Firebase Auth custom claims (super-admin, admin, vet, office), staff licences per plan and clinic statistics. Architecture: Riverpod with MVVM and repositories.",
      link: "https://github.com/Sermio/VetApp",
      images: _screenshots("VetApp", 9)),
  Project(
      name: "impoWallet",
      description:
          "Personal finance app built with Flutter that imports bank statements (Excel, CSV and PDF) from several banks, groups movements by month and categorises them with keyword rules and Gemini (Firebase AI Logic). Month detail with summary, category donut chart, searchable movements and month-to-month comparison charts. Works offline in local mode or syncs to Firestore with Google Sign-In, AES-GCM encrypted fields and App Check.",
      link: "https://github.com/Sermio/AppBancaria",
      images: _screenshots("ImpoWallet", 6)),
  Project(
      name: "MHWilds Assistant",
      description:
          "The Monster Hunter Assistant is a mobile application developed in Flutter that allows users to explore and discover information about monsters and decorations from the popular game Monster Hunter Wilds. The app features an intuitive interface that enables users to easily access details about the monsters, their abilities, and the game maps.",
      link: "https://github.com/Sermio/MHWilds_App",
      images: _screenshots("MHWilds", 13)),
  // Project(
  //     name: "Fill Good / Hidromatic",
  //     description:
  //         "White-label platform to operate a network of refill vending machines (cleaning products and purified water). React Native app with Expo Router, Tamagui and Zustand, a PHP/MySQL REST API and a Node.js WebSocket bridge that talks to the machines in real time: online status, remote price, product and hopper configuration, and duplicate-free sales sync. Dashboard, machines with stock per product, customers, alerts, user administration and Excel export.",
  //     link: "https://github.com/Sermio/FillGood",
  //     images: _screenshots("FillGood", 8)),
  Project(
      name: "LabScan",
      description:
          "Android app built with Flutter that photographs veterinary lab tickets (VetScan VS2), reads them on-device with OCR and appends each ticket as a row to an Excel workbook in OneDrive through Microsoft Graph. Microsoft sign-in with AppAuth and PKCE, OneDrive browser, batch and continuous scanning, guided correction of doubtful readings, pending drafts in secure storage and duplicate-safe retries. Covered by unit and widget tests.",
      link: "https://github.com/Sermio/Lab_scan",
      images: _screenshots("LabScan", 4)),
  // Project(
  //     name: "Bacttle",
  //     description:
  //         "Flutter and Dart adaptation of the microbiology board game Bacttle (game by Tania Miguel Trabajo, illustrations by Philippe Piccardi). Basic and advanced modes for 2 to 4 species, computer opponents, local multiplayer, guided tutorial, card atlas, the EX expansion, five languages and local saves. The rules engine is pure Dart and covered by tests.",
  //     link: "https://github.com/Sermio/bacttle",
  //     images: _screenshots("Bacttle", 6)),
  Project(
      name: "Bubble Blast",
      description:
          "Match-3 bubble popping game built with Flutter, Flame and Riverpod. Endless campaign with procedurally themed chapters and bosses, special bubbles (line, colour and cross bombs, wildcards), ice, locks, stones and chests, daily challenge with streaks, an Expedition mode with charms, a shop with tools, selectable skins, tutorial and local saves.",
      link: "https://github.com/Sermio/bubble_game",
      images: _screenshots("BubbleBlast", 5)),
  Project(
      name: "Cata",
      description:
          "Flutter and Firebase app to organise blind wine tastings. The organiser creates a tasting with the wines (alias, description, price and photo in Firebase Storage); participants rank them blind with comments, and once the tasting is closed everyone sees the aggregated ranking and can reveal the real labels. Provider for state, Cloud Firestore in real time and web deployment on Firebase Hosting.",
      link: "https://github.com/Sermio/wine_app",
      images: _screenshots("WineApp", 6)),
  Project(
      name: "Smart Climate Station",
      description:
          "IoT project: an Arduino UNO R4 WiFi publishes temperature, humidity and soil moisture to Firebase Realtime Database, and a Flutter app shows live values, keeps an offline history in SQLite, backs it up to Cloud Firestore and charts hourly, daily, weekly and monthly statistics with fl_chart. A Cloud Function sends push alerts when humidity is too high.",
      link: "https://github.com/Sermio/temperature_app",
      images: _screenshots("ClimateStation", 6)),
  Project(
      name: "Lazy Tasking",
      description:
          "Minimalist recurring-task tracker built with Flutter. Daily, weekly and monthly tasks on a pending/completed board that renew automatically, completion statistics with motivational messages, searchable history, scheduled local notifications and seven languages. Data is stored locally on the device.",
      link: "https://github.com/Sermio/task_app",
      images: _screenshots("LazyTasking", 6)),
  Project(
      name: "LiftTrack",
      description:
          "Experimental velocity based training app for Olympic weightlifting built with Flutter. The phone is fixed to the barbell and its accelerometer and gyroscope are integrated to estimate bar velocity, acceleration and bar path, with drift correction and charts. An AI Coach sends lift videos to Gemini through Firebase AI Logic for technique feedback.",
      link: "https://github.com/Sermio/gym_app",
      images: _screenshots("LiftTrack", 4)),
  Project(
      name: "Actions History",
      description:
          "Food, symptom and medication diary built with Flutter to spot intolerances: each entry has a category, photo, date and note, shown in a filterable list or a calendar view. Offline storage in SQLite, light and dark themes.",
      link: "https://github.com/Sermio/food_history",
      images: _screenshots("ActionsHistory", 5)),
  // Project(
  //     name: "Ashen Vigil",
  //     description:
  //         "Idle dark-fantasy adventure in development with Flutter and Dart, built task by task by coordinated AI agents. Data-driven pure Dart combat core (stats and modifiers, damage pipeline, status effects, skills and AI, timed encounters with a CLI demo), a sprite_forge pixel-art pipeline and a UI and currency art library. Screens show the art library and a simulated combat log.",
  //     link: "https://github.com/Sermio/iddle_incremental",
  //     images: _screenshots("AshenVigil", 2)),
  Project(
      name: "Missions",
      description:
          "This application consists of monitoring points of sale in different locations. The information that can be obtained is varied, such as the existence of products, prices, store organization, etc.",
      link: "https://github.com/Sermio/Missions_app",
      images: _screenshots("Missions", 15, ext: "png")),
  // Project(
  //     name: "VaCar",
  //     description:
  //         "VaCar is a mobile application developed in Flutter to streamline veterinary clinic management. It enables veterinarians to manage orders, schedule appointments, and maintain detailed records of clients and pets, enhancing efficiency and simplifying operations.",
  //     link: "https://github.com/Sermio/VaCar",
  //     images: [
  //       "assets/images/Vacar/1.png",
  //       "assets/images/Vacar/2.png",
  //       "assets/images/Vacar/3.png",
  //       "assets/images/Vacar/4.png",
  //       "assets/images/Vacar/5.png",
  //       "assets/images/Vacar/6.png",
  //       "assets/images/Vacar/7.png",
  //       "assets/images/Vacar/8.png",
  //       "assets/images/Vacar/9.png",
  //       "assets/images/Vacar/10.png",
  //       "assets/images/Vacar/11.png",
  //     ]),
  Project(
      name: "Monster Hunter",
      description:
          "The Monster Hunter is a mobile application developed in Flutter that allows users to explore and discover information about monsters and decorations from the popular game Monster Hunter. The app features an intuitive interface that enables users to easily access details about the monsters, their abilities, and the game maps. ",
      link: "https://github.com/Sermio/MH_app",
      images: _screenshots("MHW", 6, ext: "png")),
  Project(
      name: "WorldShift",
      description:
          "The WorldShift Tribute Application is a tribute to the game WorldShift (2008), designed as a comprehensive interactive catalog of in-game items. It offers users an intuitive way to browse, search, and filter through a vast collection of equipment. With a strong emphasis on accuracy and usability, it allows for detailed item exploration, making it an invaluable tool for both casual players and dedicated strategists.",
      link: "https://github.com/Sermio/WD_filter",
      images: _screenshots("Worldshift", 8)),
  Project(
      name: "Diseños",
      description:
          "A mobile app that demonstrates a variety of custom UI designs and animations. This app serves as a showcase of different layouts and UI components like slideshows, list views, custom headers, custom progress bars, and more. Perfect for developers looking for inspiration or trying to implement similar designs in their own apps.",
      link: "https://github.com/Sermio/disenos_app",
      images: _screenshots("Disenos", 6, ext: "png")),
  Project(
      name: "QR scanner",
      description:
          "This app allows users to scan QR codes quickly and efficiently. By using the camera on a mobile device, the app can detect and interpret QR codes, providing users with the possibility to send encoded data from the QR code to a backend. The app features an intuitive interface, with easy-to-use functionality for both beginners and advanced users. It also ensures security and privacy by not storing or sharing scanned information without user consent.",
      link: "https://github.com/Sermio/QR_scan",
      images: _screenshots("QRScan", 5, ext: "png")),
  Project(
      name: "Subasta Forestal",
      description:
          "The Subasta Forestal application is an intuitive technology platform designed for those interested in buying or selling wood. The visual design of the app was provided by the client to be followed accordingly.\n This application is aimed at both PROPERTY OWNERS (individuals and forestry communities) and BUYERS (self-employed individuals and companies).",
      link: "https://github.com/Sermio/Subasta_forestal",
      images: _screenshots("SubastaForestal", 4, ext: "png")),
  Project(
      name: "Shoes",
      description:
          "A mobile app that allows users to view a product with the option to select different colors and interactive animations to enhance the user experience.",
      link: "https://github.com/Sermio/ShoesApp",
      images: _screenshots("Shoes", 2, ext: "png")),
  Project(
      name: "Music Player",
      description:
          "Music player app with animated visualizations, an intuitive interface, and responsive design, built with Flutter and state managed using Provider.",
      link: "https://github.com/Sermio/music_player",
      images: _screenshots("MusicPlayer", 1, ext: "png")),
];
