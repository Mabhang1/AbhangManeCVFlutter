import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:portfolio/model/models.dart';
import 'package:portfolio/resource/styles.dart';
import 'package:url_launcher/url_launcher.dart';


enum ScreenType { mobile, tab, web }

class AppClass {
  static final AppClass _mAppClass = AppClass._internal();
  static BuildContext? lastContext;
  ScrollController controller = ScrollController();

  /* URL */
  static final resumeDownloadURL =
      '''https://jeeva-portfolio.s3.amazonaws.com/JEEVANANDHAM's+Resume.pdf''';

  static final gitTodo = '''https://github.com/Mabhang1/ToDoFlutter''';

  static final gitInstaClone= '''https://github.com/Mabhang1/Instagram_Clone_Flutter''';
  static final gitIMS ='''https://github.com/Mabhang1/IMS''';

  List<WorkModel> projectList = [
    WorkModel(
        projectTitle: "ToDo",
        projectContent:
            "Developed a ToDo application using Flutter and Dart, resulting in a 20% increase in task management efficiency. Implemented features to create, manage, and delete tasks, leading to a 30% reduction in missed deadlines. Developed a cross-platform responsive application. ",
        tech1: "Flutter"),
    WorkModel(
        projectTitle: "Instagram Clone",
        projectContent:
            "Feature-rich Instagram clone built using the Flutter framework. It offers users a seamless and visually appealing social media experience similar to the popular Instagram platform. With its modern design and smooth animations, FlutterGram brings the best of Instagram's functionality to the fingertips of its users.",
        tech1: "Flutter",
        tech2: "Firebase"),
    WorkModel(
        projectTitle: "IMS",
        projectContent:
            '''Developed a Ticket Management System for efficient management, prioritization, and maintenance of requests.Implemented using Bootstrap, HTML, and CSS, ensuring optimal user experience across various devices and screen sizes, resulting in a 25% increase in user engagement and a 15% decrease in bounce rate.''',
        tech1: "PHP",
        tech2: "MySQL",
        tech3: "Web"),
  ];

  factory AppClass() {
    return _mAppClass;
  }

  AppClass._internal();

  getMqWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getMqHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  showSnackBar(String msg, {BuildContext? context}) {
    ScaffoldMessenger.of(context ?? lastContext!)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  ScreenType getScreenType(BuildContext context) {
    double scrWidth = getMqWidth(context);
    if (scrWidth > 915) {
      return ScreenType.web;
    } else if (scrWidth < 650) {
      return ScreenType.mobile;
    }
    return ScreenType.tab;
  }

  downloadResume(context) async {
    await launchUrl(Uri.parse(AppClass.resumeDownloadURL));
  }

  alertDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(title, style: TxtStyle().boldWhite(context)),
                content: Text(msg),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Okay'))
                ]));
  }

  Future<bool> sendEmail(name, contact, msg) async {
    var url = Uri.https('hbk-portfolio-mailer.web.app', '/sendMail');
    var response = await post(url, body: {
      "name": name,
      "contactInfo": contact,
      "message": msg
    }).timeout(Duration(seconds: 10));
    print(response.body);
    return response.statusCode == 200;
  }
}
