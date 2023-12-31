

// class PostContainer extends StatefulWidget {
//   final Post post;
//   final int columns;

//   const PostContainer({
//     Key? key,
//     required this.post,
//     this.columns = 3,
//   }) : super(key: key);

//   @override
//   _PostContainerState createState() => _PostContainerState();
// }

// class _PostContainerState extends State<PostContainer> {
//   int initialImageCount = 5;
//   int imagesPerPage = 6;
//   int remainingImagesCount = 0;
//   late NavigationBloc navigationBloc;

//   bool showFullCaption = false;

//   String paginateCaption(String caption, int wordCount) {
//     List<String> words = caption.split(' ');
//     if (words.length <= wordCount || showFullCaption) {
//       return caption;
//     } else {
//       return '${words.sublist(0, wordCount).join(' ')}...';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     remainingImagesCount = (widget.post.eachMedia.length) - initialImageCount;
//     navigationBloc = BlocProvider.of<NavigationBloc>(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     const desiredWidthPercentage = 0.9;
//     const desiredHeightPercentage = 0.3;

//     final width = screenWidth * desiredWidthPercentage;
//     final height = screenHeight * desiredHeightPercentage;

//     int rows = (widget.post.eachMedia.length) ~/ widget.columns.ceil();
//     List<List<String>> imageRows = [];
//     for (int i = 0; i < rows; i++) {
//       int start = i * widget.columns;
//       int end = (i + 1) * widget.columns;
//       if (end > (widget.post.eachMedia.length)) {
//         end = (widget.post.eachMedia.length);
//       }
//       imageRows.add(widget.post.eachMedia
//           .sublist(start, end)
//           .map((media) => media.media)
//           .toList()
//           .cast<String>());
//     }

//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => PostDetailsPage(post: widget.post),
//           ),
//         );
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(
//           vertical: 5.0,
//           horizontal: 10.0,
//         ),
//         elevation: 0.0,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           color: Colors.white,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     PostHeader(
//                       post: widget.post,
//                     ),
//                     const SizedBox(height: 10.0),
//                     if (widget.post.content!.isNotEmpty)
//                       RichText(
//                         text: TextSpan(
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: paginateCaption(
//                                   widget.post.content ?? '', 20),
//                               style: DefaultTextStyle.of(context).style,
//                             ),
//                             if ((widget.post.content!.split(' ').length) > 20 &&
//                                 !showFullCaption)
//                               TextSpan(
//                                 text: ' Read More',
//                                 style: const TextStyle(
//                                   color: Color.fromRGBO(0, 0, 0, 0.7),
//                                 ),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     setState(() {
//                                       showFullCaption = true;
//                                     });
//                                   },
//                               ),
//                           ],
//                         ),
//                       ),
//                     Text(widget.post.hashtags
//                         .map((hashtag) => hashtag.hashTags)
//                         .join(', ')),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 17.0),
//               if ((widget.post.eachMedia.length) <= initialImageCount)
//                 Column(
//                   children: [
//                     for (List<String> sublist in imageRows)
//                       Row(
//                         children: [
//                           for (String imageUrl in sublist)
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(1000.0),
//                                 ),
//                                 child: CachedNetworkImage(
//                                   imageUrl: imageUrl,
//                                   width: width / widget.columns,
//                                   height: height,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                   ],
//                 )
//               else
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         for (int i = 0; i < min(4, imageRows[0].length); i++)
//                           Expanded(
//                             child: CachedNetworkImage(
//                               imageUrl: imageRows[0][i],
//                               width: width / widget.columns,
//                               height: height,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                       ],
//                     ),
//                     if (remainingImagesCount > 0)
//                       Container(
//                         alignment: Alignment.center,
//                         color: Colors.black.withOpacity(0.6),
//                         child: Text(
//                           '+$remainingImagesCount',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24.0,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               const SizedBox(height: 17.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: PostStats(
//                   post: widget.post,
//                   context: context,
//                   postStatsKey: GlobalKey(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
