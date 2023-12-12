import 'dart:async';
import 'package:_2geda/SideBar/bloc_navigation/navigation_bloc.dart';
import 'package:_2geda/SideBar/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => NavigationBloc(),
        child: const SideBar(),
      ),
    );
  }
}

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  late NavigationBloc navigationBloc; // Declare navigationBloc here

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;

    // Initialize navigationBloc here
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
      navigationBloc.add(NavigationEvents.CloseSidebarEvent);
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
      navigationBloc.add(NavigationEvents.OpenSidebarEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        const sidebarWidthPercentage =
            50; // Change this percentage to your desired width

        final sidebarWidth = isSideBarOpenedAsync.data == true
            ? screenWidth *
                (sidebarWidthPercentage /
                    0.25) // Sidebar open, set to the specified percentage of the screen width
            : 30.0; // Sidebar closed, set to 25.0

        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : (-screenWidth + sidebarWidth),
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - sidebarWidth,
          child: Container(
            margin:
                EdgeInsets.only(right: isSideBarOpenedAsync.data! ? 100 : 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    color: const Color(0xff4e0ca2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "assets/2geda-logo.png",
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          title: "Home",
                          onTap: () {
                            onIconPressed();
                            navigationBloc
                                .add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.people,
                          title: "Connect",
                          onTap: () {
                            onIconPressed();
                            navigationBloc
                                .add(NavigationEvents.ConnectPageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.store,
                          title: "Commerce",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.CommerceClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.book,
                          title: "Business Directory",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc.add(
                                NavigationEvents.BusinessDirectoryClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.chat,
                          title: "Chat",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.ChatClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.person_2_outlined,
                          title: "Profile",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.ProfileClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.airplane_ticket,
                          title: "Ticket",
                          onTap: () {
                            onIconPressed();
                            navigationBloc
                                .add(NavigationEvents.TicketClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.live_tv,
                          title: "Live",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.LiveClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.tv,
                          title: "TV",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.StereoClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.album,
                          title: "Stereo",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.StereoClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.poll,
                          title: "Voting",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.VotingClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.library_books,
                          title: "Education",
                          onTap: () {
                            onIconPressed();
                            // Add navigation logic here
                            navigationBloc
                                .add(NavigationEvents.EducationClickedEvent);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100.0), // Add top padding here
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff4e0ca2),
                        ),
                        child: Center(
                          child: Icon(
                            isSideBarOpenedAsync.data!
                                ? Icons
                                    .arrow_back_ios_rounded // Use the arrow back icon when the sidebar is open
                                : Icons
                                    .arrow_forward_ios_rounded, // Use the forward arrow icon when the sidebar is closed
                            color: Colors.white,
                            size: 20, // Adjust the size of the icons as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
