
// CardSwiper(
//                   cardBuilder: (BuildContext context,
//                       int index,
//                       int horizontalOffsetPercentage,
//                       int verticalOffsetPercentage) {
//                     Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         // Media Content (Image or Video)
//                         // for (var i in stories)
//                         SizedBox(
//                           // Example background color for media content
//                           child: PageView.builder(
//                             controller: _pageController,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount:
//                                 cnnctProvider.value.data![index].media.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 height: 630,
//                                 decoration: const BoxDecoration(
//                                     color: kPrimary2,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20))),
//                                 child: Image.network(
//                                   cnnctProvider.value.data![index].media[index]
//                                       .profileImage,
//                                   width: double.infinity,
//                                   height: double.infinity,
//                                   fit: BoxFit.contain,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         // Percent Indicators
//                         Positioned(
//                           top: 25.0,
//                           left: 10.0,
//                           right: 10.0,
//                           child: Column(
//                             children: <Widget>[
//                               Row(
//                                 children: cnnctProvider.value.data![index].media
//                                     .asMap()
//                                     .map((i, e) {
//                                       return MapEntry(
//                                         i,
//                                         AnimatedBar(
//                                           animController: _animationController,
//                                           position: i,
//                                           currentIndex: _currentIndex,
//                                         ),
//                                       );
//                                     })
//                                     .values
//                                     .toList(),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 1.5,
//                                   vertical: 10.0,
//                                 ),
//                                 // child: UserInfo(user: story.imageName),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                             top: 35.0,
//                             right: 24.0,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(50),
//                                 color: kblckBtn,
//                               ),
//                               width: 40,
//                               height: 40,
//                               child: const Icon(
//                                 Icons.share,
//                                 color: Colors.white,
//                                 size: 16,
//                               ),
//                             )),
//                         Positioned(
//                             bottom: 78,
//                             right: 19,
//                             child: Container(
//                               constraints: BoxConstraints(
//                                 maxWidth: MediaQuery.of(context).size.width,
//                               ),
//                               width: 57,
//                               height: 50,
//                               padding: const EdgeInsets.symmetric(),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white
//                                     .withOpacity(0.20000000298023224),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                       width: 30,
//                                       height: 30,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: const BoxDecoration(),
//                                       child: const Icon(
//                                         Icons.image_outlined,
//                                         color: kblckBtn,
//                                       )),
//                                   const SizedBox(width: 5),
//                                   // for (var i in stories)
//                                   Text(
//                                     cnnctProvider
//                                         .value.data![index].media.length
//                                         .toString(),
//                                     style: const TextStyle(
//                                       color: Color(0xFF151313),
//                                       fontSize: 16,
//                                       fontFamily: 'Ubuntu',
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                         Positioned(
//                             bottom: 67,
//                             left: 24.0,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CircleAvatar(
//                                   child: Image.asset(
//                                     'assets/avatar.png',
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 16,
//                                 ),
//                                 const Text(
//                                   'Mercy Aik',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                     height: 0,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   '@${cnnctProvider.value.data![index].username}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 const Text(
//                                   'Abeokuta, 56km from you',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     height: 0,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 const SizedBox(
//                                   child: Text(
//                                     'No bio yet.',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                       height: 0.09,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ))
//                         // Text Overlay
//                         ,
//                         Positioned(
//                           bottom: -20,
//                           left: 20,
//                           right: 20,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 143,
//                                 height: 51,
//                                 decoration: ShapeDecoration(
//                                   color: kPrimary1,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     'Chat',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 35,
//                               ),
//                               Container(
//                                 width: 143,
//                                 height: 51,
//                                 decoration: ShapeDecoration(
//                                   color: kPrimary,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     'Stick',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Filling Animation
//                       ],
//                     );
//                     return null;
//                   },
//                   cardsCount: cnnctProvider.value.data![0].media.length,
//                 );