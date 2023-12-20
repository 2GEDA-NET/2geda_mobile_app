import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_feeds_headr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../posts/comment/post_comment.dart';

class PostFeedDetails extends StatelessWidget {
  String? imgUrl;
  String? country;
  String? timePosted;
  String? postID;
  String? content;
  String? username;
  List<Hashtag>? hashtags;
  List<EachMedia> eachMedia;
  List<CommentText> commentText;
  PostFeedDetails(
      {super.key,
      this.country,
      required this.commentText,
      this.username,
      this.imgUrl,
      this.timePosted,
      this.content,
      required this.eachMedia,
      this.hashtags,
      this.postID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff8e3bce), Color(0xff5816a2)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Feeds',
          style: TextStyle(
            color: Colors.white, // Text color
            // You can also adjust other text styles such as fontSize, fontWeight, etc.
          ),
        ),
        centerTitle: true, // Center-align the title text
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff8e3bce), Color(0xff5816a2)],
                  ),
                ),
                child: PostFeedDetailsHeader(
                  username: username ?? '',
                  imgUrl: imgUrl ?? '',
                  timePosted: timePosted ?? '',
                  country: country ?? '',
                )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Text(content ?? ''),
            ),
            const SizedBox(
              height: 5,
            ),
            hashtags!.isEmpty
                ? const SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: Text(hashtags!
                        .map((hashtag) => hashtag.hashTags)
                        .join(', ')),
                  ),
            const SizedBox(
              height: 24,
            ),
            eachMedia.isEmpty
                ? const SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: eachMedia.length,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CachedNetworkImage(
                              imageUrl: eachMedia[i].media ?? '',
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
            const SizedBox(
              height: 24,
            ),
            ///// Reactio nseg
            const SizedBox(
              height: 15,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),

            CommentSection(
              commentText: commentText,
            )
          ],
        ),
      ),
    );
  }
}
