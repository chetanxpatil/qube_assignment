import 'dart:convert';

UserFeeling userFeelingFromJson(String str) =>
    UserFeeling.fromJson(json.decode(str));

class UserFeeling {
  UserFeeling({
    required this.status,
    required this.data,
  });

  final String status;
  final Data data;

  factory UserFeeling.fromJson(Map<String, dynamic> json) => UserFeeling(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.feelingPercentage,
    required this.feelingList,
    required this.videoArr,
  });

  final FeelingPercentage feelingPercentage;
  final List<FeelingList> feelingList;
  final List<VideoArr> videoArr;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        feelingPercentage:
            FeelingPercentage.fromJson(json["feeling_percentage"]),
        feelingList: List<FeelingList>.from(
            json["feeling_list"].map((x) => FeelingList.fromJson(x))),
        videoArr: List<VideoArr>.from(
            json["video_arr"].map((x) => VideoArr.fromJson(x))),
      );
}

class FeelingList {
  FeelingList({
    required this.feelingName,
    required this.submitTime,
  });

  final String feelingName;
  final DateTime submitTime;

  factory FeelingList.fromJson(Map<String, dynamic> json) => FeelingList(
        feelingName: json["feeling_name"],
        submitTime: DateTime.parse(json["submit_time"]),
      );
}

class FeelingPercentage {
  FeelingPercentage({
    this.happy,
    this.sad,
    this.energetic,
    this.calm,
    this.angry,
    this.bored,
    this.love,
  });

  final String? happy;
  final String? sad;
  final String? energetic;
  final String? calm;
  final String? angry;
  final String? bored;
  final String? love;

  factory FeelingPercentage.fromJson(Map<String, dynamic> json) =>
      FeelingPercentage(
        happy: json["Happy"],
        sad: json["Sad"],
        energetic: json["Energetic"],
        calm: json["Calm"],
        angry: json["Angry"],
        bored: json["Bored"],
        love: json["love"],
      );

  List<Mood> get moods => [
        if (energetic != null)
          Mood(
            title: "Energetic",
            // emoji: "⚡",
            percentage: energetic.toString(),
          ),
        if (sad != null)
          Mood(
            title: "Sad",
            // emoji: "😢",
            percentage: sad.toString(),
          ),
        if (happy != null)
          Mood(
            title: "Happy",
            // emoji: "😀",
            percentage: happy.toString(),
          ),
        if (angry != null)
          Mood(
            title: "Angry",
            // emoji: "😡",
            percentage: angry.toString(),
          ),
        if (calm != null)
          Mood(
            title: "Calm",
            // emoji: "🍃",
            percentage: calm.toString(),
          ),
        if (bored != null)
          Mood(
            title: "Bored",
            // emoji: "😖",
            percentage: bored.toString(),
          ),
        if (love != null)
          Mood(
            title: "Love",
            // emoji: "🥰",
            percentage: love.toString(),
          ),
      ];
}

class VideoArr {
  VideoArr({
    required this.youtubeUrl,
  });

  final String youtubeUrl;

  factory VideoArr.fromJson(Map<String, dynamic> json) => VideoArr(
        youtubeUrl: json["youtube_url"],
      );
}

class Mood {
  final String title;
  // final String emoji;
  final String percentage;

  Mood({
    required this.title,
    // required this.emoji,
    required this.percentage,
  });
}
