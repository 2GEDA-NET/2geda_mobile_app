import 'package:_2geda/utils/constant/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostComponent extends StatelessWidget {
  String? imageUrl;
  String? name;
  String? location;
  String? timePosted;
  String? content;
  PostComponent(
      {super.key,
      this.imageUrl,
      this.name,
      this.location,
      this.timePosted,
      this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: kwhite,
          width: MediaQuery.sizeOf(context).width,
          height: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(100),
                        shape: BoxShape.rectangle,
                        color: Colors.grey[300]!,
                      ),
                    ),
                    // Container(
                    //     alignment: Alignment.topLeft,
                    //     child: CachedNetworkImage(
                    //       imageUrl: imageUrl ?? '',
                    //       height: 42,
                    //       width: 42,
                    //     )),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            name ?? '',
                            style: const TextStyle(
                              color: Color(0xFF4E0CA2),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                            child: Text(
                          location ?? '',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4000000059604645),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        child: Text(
                      timePosted ?? '',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6000000238418579),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      content ?? '',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.699999988079071),
                        fontSize: 13,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500,
                        height: 0.11,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 123,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    color: Colors.grey[300]!,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
