// ignore_for_file: unused_import

import 'package:_2geda/SideBar/bloc_navigation/navigation_bloc.dart';
import 'package:_2geda/pages/businessDirectoryPages/business_directory.dart';
import 'package:_2geda/pages/chatPages/chat.dart';
import 'package:_2geda/pages/commercePages/commerce.dart';
import 'package:_2geda/pages/connect/presentation/connect.dart';
import 'package:_2geda/pages/connectPages/connect.dart';
import 'package:_2geda/pages/educationPages/education.dart';
import 'package:_2geda/pages/homeScreens/home_screen.dart';
import 'package:_2geda/pages/homeScreens/searchPages/search_screen.dart';
import 'package:_2geda/pages/walletPages/wallet.dart';
import 'package:_2geda/pages/widgets/posts/post_details.dart';
import 'package:_2geda/pages/livePages/live.dart';
import 'package:_2geda/pages/profilePages/profile.dart';
import 'package:_2geda/pages/stereoPages/stereo.dart';
import 'package:_2geda/pages/ticketPages/ticket.dart';
import 'package:_2geda/pages/votingPages/voting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  const SideBarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, state) {
                if (state == NavigationStates.HomeScreenState) {
                  return const HomeScreen(); // Return your HomeScreen widget here.
                } else if (state == NavigationStates.ConnectScreenState) {
                  return const ConnectWithOtherUsers(); // Return another screen widget here.
                } else if (state == NavigationStates.CommerceScreenState) {
                  return const CommerceScreen();
                } else if (state ==
                    NavigationStates.BusinessDirectoryScreenState) {
                  return const BusinessDirectory();
                } else if (state == NavigationStates.ChatScreenState) {
                  return const ChatScreen();
                } else if (state == NavigationStates.ProfileScreenState) {
                  return const ProfileScreen();
                } else if (state == NavigationStates.TicketPageState) {
                  return const TicketPage();
                } else if (state == NavigationStates.LiveScreenState) {
                  return const LiveScreen();
                } else if (state == NavigationStates.StereoScreenState) {
                  return const StereoScreen();
                } else if (state == NavigationStates.VotingScreenState) {
                  return const VotingScreen();
                } else if (state == NavigationStates.EducationScreenState) {
                  return const EducationScreen();
                } else if (state == NavigationStates.PostDetailScreenState) {
                  // return PostDetailsPage();
                } else if (state == NavigationStates.SearchPageScreenState) {
                  return SearchScreen();
                }else if (state == NavigationStates.WalletPageScreenState) {
                  return WalletScreen();
                }
                // Handle other states or return a default widget.
                return Container();
              },
            ),
            const SideBar(),
          ],
        ),
      ),
    );
  }
}
