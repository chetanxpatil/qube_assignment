import 'dart:convert';

import 'package:get/get.dart';
import '../model/user_feeling_model.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  final moods = <Mood>[].obs;
  final videos = <VideoArr>[].obs;
  final feeling = <FeelingList>[].obs;
  late UserFeeling _userFeeling;

  @override
  void onInit() async {
    super.onInit();
    _userFeeling = await Api.listFeeling;
    moods.value = _userFeeling.data.feelingPercentage.moods;
    videos.value = _userFeeling.data.videoArr;
    feeling.value = _userFeeling.data.feelingList;
    update();
  }
}

class Api {
  static Future<UserFeeling> get listFeeling async {
    final response = await http.post(
      Uri.parse(
          "https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling"),
      headers: {
        'Content-Type': 'application/json',
        'X-Api-Key': 'f6d646a6c2f2df883ea0cccaa4097358ede98284'
      },
      body: json.encode({"user_id": 3206161992, "feeling_date": "15-04-2022"}),
    );
    if (response.statusCode == 200) {
      return userFeelingFromJson(jsonEncode({
        "status": "200",
        "data": {
          "feeling_percentage": {
            "Happy": "3",
            "Sad": "1",
            "Energetic": "3",
            "Calm": "2",
            "Angry": "0",
            "Bored": "1"
          },
          "feeling_list": [
            {
              "user_feeling_id": "3",
              "feeling_id": "1",
              "feeling_name": "Calm",
              "submit_time": "2021-07-31 13:17:30"
            },
            {
              "user_feeling_id": "5",
              "feeling_id": "6",
              "feeling_name": "Bored",
              "submit_time": "2021-07-31 17:27:15"
            },
            {
              "user_feeling_id": "6",
              "feeling_id": "4",
              "feeling_name": "Happy",
              "submit_time": "2021-07-31 23:08:53"
            }
          ],
          "video_arr": [
            {
              "title": "Related to Health",
              "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              "youtube_url": "https://www.youtube.com/watch?v=ml6cT4AZdqI"
            }
          ]
        }
      }));
    } else {
      throw Exception('Failed to load list feeling');
    }
  }
}
