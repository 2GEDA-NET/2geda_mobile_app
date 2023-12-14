import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs_pages/all.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs_pages/image_tab.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs_pages/location_tab.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs_pages/product_tab.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs_pages/video_tab.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_tabs_pages/voice_notes.dart';
import 'package:flutter/material.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({super.key});

  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  int _currentIndex = 0; // Initialize with the first tab (All)

  @override
  Widget build(BuildContext context) {
    Widget currentTabContent = AllTabContent(
      currentIndex: _currentIndex,
    ); // Initialize with a default tab content

    if (_currentIndex == 0) {
      currentTabContent = AllTabContent(
        currentIndex: _currentIndex,
      );
    } else if (_currentIndex == 1) {
      currentTabContent = ImagesTabContent(
        currentIndex: _currentIndex,
      );
    } else if (_currentIndex == 2) {
      currentTabContent = VideosTabContent(
        currentIndex: _currentIndex,
      );
    } else if (_currentIndex == 3) {
      currentTabContent = ProductsTabContent(
        currentIndex: _currentIndex,
      );
    } else if (_currentIndex == 4) {
      currentTabContent = VoiceNotesTabContent(
        currentIndex: _currentIndex,
      );
    } else if (_currentIndex == 5) {
      currentTabContent = LocationTabContent(
        currentIndex: _currentIndex,
      );
    }

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildTabButtons(
              tabLabels: [
                'All Posts',
                'Images',
                'Videos',
                'Products',
                'Voice notes',
                'Location'
              ],
              currentIndex: _currentIndex,
              onTabPressed: (index) {
                setState(() {
                  _currentIndex = index; // Update the selected tab index
                });
              },
            ),
          ),
        ),
        // Include the currentTabContent widget here
        currentTabContent,
      ],
    );
  }
}
