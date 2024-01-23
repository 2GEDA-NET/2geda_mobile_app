import 'dart:convert';

import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStor {
  static Future<void> saveFeeds(List<Post> feeds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'feeds',
      feeds.map((feed) => json.encode(feed.toJson())).toList(),
    );
  }

  static Future<List<Post>> getFeeds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonFeeds = prefs.getStringList('feeds') ?? [];
    return jsonFeeds
        .map((jsonFeed) => Post.fromJson(json.decode(jsonFeed)))
        .toList();
  }
}
