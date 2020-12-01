import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const YOUTUBE_API_KEY = "YOUTUBE API";
const CHANNEL_ID = "UC_x5XG1OV2P6uZZ5FSM9Ttw";
const BASE_URL = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> searching(String search) async {
    http.Response response = await http.get(
      BASE_URL + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$YOUTUBE_API_KEY"
          "&channelId=$CHANNEL_ID" //remove for search in all youtube
          "&q=s$search"
    );

    if(response.statusCode == 200) {

      Map<String, dynamic> dataJson = json.decode(response.body);

      List<Video> videos = dataJson["items"].map<Video> (
          (map) { return Video.fromJson(map); }
      ).toList();
      return videos;
    } else {
      print("AQUI");
    }
  }
}