import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostFeedDetailsHeader extends StatefulWidget {
  String? imgUrl;
  String? country;
  String? timePosted;
  String? username;
  PostFeedDetailsHeader({
    this.username,
    this.country,
    this.imgUrl,
    this.timePosted,
    super.key,
  });

  @override
  State<PostFeedDetailsHeader> createState() => PostFeedDetailsHeaderState();
}

class PostFeedDetailsHeaderState extends State<PostFeedDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: CachedNetworkImage(imageUrl: widget.imgUrl ?? ''),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4e0ca2),
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.country ?? '',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          widget.timePosted ?? '',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
