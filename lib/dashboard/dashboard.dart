import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qube/dashboard/controller/dashboard_controller.dart';
import 'package:qube/dashboard/support/kcolors.dart';
import 'package:qube/dashboard/support/kpad.dart';
import 'package:qube/dashboard/support/strings.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/feeling_tile.dart';
import 'model/user_feeling_model.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final dashController = Get.put<DashboardController>(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new),
        title: Text(KStrings.dasTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Kpad.h22(
              child: Text(
                KStrings.dsh1,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              top: 20,
            ),
            Kpad.h22(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dashController.moods
                      .map(
                        (Mood mood) => FeelingTile(
                          emoji: mood.title.emoji,
                          title: mood.title,
                          percentage: mood.percentage,
                        ),
                      )
                      .toList(),
                ),
              ),
              top: 20,
            ),
            Divider(
              height: 30,
              thickness: 0.2,
              color: Colors.black.withOpacity(0.3),
            ),
            Kpad.h22(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KColors.lightBlue,
                ),
                child: Text(
                  current,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Kpad.h22(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (DateTime day in days7)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 40,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isToday(day)
                            ? KColors.matBlack
                            : Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayName(day),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: isToday(day) ? Colors.white : null,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            day.day.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: isToday(day) ? Colors.white : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Divider(
              height: 40,
              thickness: 0.2,
              color: Colors.black.withOpacity(0.3),
            ),
            Kpad.h22(
              child: Obx(() {
                DateFormat dateFormat = DateFormat.jm();
                return Column(
                  children: dashController.feeling
                      .map((FeelingList element) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    dateFormat.format(element.submitTime),
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${element.feelingName.emoji} ${element.feelingName}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Spacer(),
                              ],
                            ),
                          ))
                      .toList(),
                );
              }),
            ),
            Divider(
              height: 20,
              thickness: 0.2,
              color: Colors.black.withOpacity(0.3),
            ),
            Kpad.h22(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "You May Find This Interesting",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit euismod risus elementum magna scelerisque nunc sed varius. Tellus quis tristique adipiscing sed metus, sit ac adipiscing. Leo aenean sed eu purus maecenas posuere ",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )
                ],
              ),
              top: 10,
            ),
            SizedBox(
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Obx(() => Row(
                      children: dashController.videos
                          .map(
                            (element) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              height: 120,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _launchUrl(Uri.parse(element.youtubeUrl));
                                },
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        youtubeThumbNail(element.youtubeUrl),
                                        fit: BoxFit.fitWidth,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 30,
                                          child: Image.asset(
                                            "assets/youtube.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication)) {
    throw 'Could not launch $url';
  }
}

bool isToday(DateTime day) {
  return day.day == DateTime.now().day;
}

String dayName(DateTime day) {
  return DateFormat('EEEE').format(day).substring(0, 2);
}

String get current => DateFormat('dd MMMM, yyyy').format(DateTime.now());

List<DateTime> get days7 {
  String day = DateFormat('EEEE').format(DateTime.now()).substring(0, 2);
  DateTime initialDate = DateTime.now();
  switch (day) {
    case "Mo":
      initialDate = DateTime.now();
      break;
    case "Tu":
      initialDate = DateTime.now().subtract(const Duration(days: 1));
      break;
    case "We":
      initialDate = DateTime.now().subtract(const Duration(days: 2));
      break;
    case "Th":
      initialDate = DateTime.now().subtract(const Duration(days: 3));
      break;
    case "Fr":
      initialDate = DateTime.now().subtract(const Duration(days: 4));
      break;
    case "Sa":
      initialDate = DateTime.now().subtract(const Duration(days: 5));
      break;
    case "Su":
      initialDate = DateTime.now().subtract(const Duration(days: 5));
      break;
  }

  return List.generate(7, (index) => initialDate.add(Duration(days: index)));
}

String youtubeThumbNail(String url) {
  return "https://img.youtube.com/vi/${url.substring(url.length - 11)}/0.jpg";
}

extension on String {
  String get emoji {
    switch (toLowerCase()) {
      case "energetic":
        return "⚡";
      case "sad":
        return "😢";
      case "happy":
        return "😀";
      case "angry":
        return "😡";
      case "calm":
        return "🍃";
      case "bored":
        return "😖";
      case "love":
        return "🥰";
      default:
        return "";
    }
  }
}
