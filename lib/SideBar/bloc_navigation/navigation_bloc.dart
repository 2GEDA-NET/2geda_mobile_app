// Import your page classes
// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';

// Define the states for your NavigationBloc (you can customize this)
enum NavigationStates {
  SidebarOpenedState,
  SidebarClosedState,
  HomeScreenState,
  ConnectScreenState,
  CommerceScreenState,
  BusinessDirectoryScreenState,
  ChatScreenState,
  ProfileScreenState,
  TicketPageState,
  LiveScreenState,
  StereoScreenState,
  VotingScreenState,
  EducationScreenState,
  PostDetailScreenState,
  SearchPageScreenState,
  // Add more states as needed
}

enum NavigationEvents {
  HomePageClickedEvent,
  ConnectPageClickedEvent,
  CommerceClickedEvent,
  BusinessDirectoryClickedEvent,
  ChatClickedEvent,
  ProfileClickedEvent,
  TicketClickedEvent,
  LiveClickedEvent,
  StereoClickedEvent,
  VotingClickedEvent,
  EducationClickedEvent,
  CloseSidebarEvent,
  OpenSidebarEvent,
  PostDetailClickEvent,
  SearchPageClickEvent,
}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(NavigationStates.HomeScreenState) {
    // Register event handlers for your events
    on<NavigationEvents>((event, emit) {
      // Handle your events and emit new states here
      if (event == NavigationEvents.HomePageClickedEvent) {
        emit(NavigationStates.HomeScreenState);
      } else if (event == NavigationEvents.ConnectPageClickedEvent) {
        emit(NavigationStates.ConnectScreenState);
      } else if (event == NavigationEvents.CommerceClickedEvent) {
        emit(NavigationStates.CommerceScreenState);
      } else if (event == NavigationEvents.BusinessDirectoryClickedEvent) {
        emit(NavigationStates.BusinessDirectoryScreenState);
      } else if (event == NavigationEvents.ChatClickedEvent) {
        emit(NavigationStates.ChatScreenState);
      } else if (event == NavigationEvents.ProfileClickedEvent) {
        emit(NavigationStates.ProfileScreenState);
      } else if (event == NavigationEvents.TicketClickedEvent) {
        emit(NavigationStates.TicketPageState);
      } else if (event == NavigationEvents.LiveClickedEvent) {
        emit(NavigationStates.LiveScreenState);
      } else if (event == NavigationEvents.StereoClickedEvent) {
        emit(NavigationStates.StereoScreenState);
      } else if (event == NavigationEvents.VotingClickedEvent) {
        emit(NavigationStates.VotingScreenState);
      } else if (event == NavigationEvents.EducationClickedEvent) {
        emit(NavigationStates.EducationScreenState);
      } else if (event == NavigationEvents.PostDetailClickEvent) {
        emit(NavigationStates.PostDetailScreenState);
      } else if (event == NavigationEvents.SearchPageClickEvent) {
        emit(NavigationStates.SearchPageScreenState);
      }
      // Add more event handling logic for other events
    });
  }

  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    if (event == NavigationEvents.HomePageClickedEvent) {
      yield NavigationStates.HomeScreenState;
    } else if (event == NavigationEvents.ConnectPageClickedEvent) {
      yield NavigationStates.ConnectScreenState;
    } else if (event == NavigationEvents.CommerceClickedEvent) {
      yield NavigationStates.CommerceScreenState;
    } else if (event == NavigationEvents.BusinessDirectoryClickedEvent) {
      yield NavigationStates.BusinessDirectoryScreenState;
    } else if (event == NavigationEvents.ChatClickedEvent) {
      yield NavigationStates.ChatScreenState;
    } else if (event == NavigationEvents.ProfileClickedEvent) {
      yield NavigationStates.ProfileScreenState;
    } else if (event == NavigationEvents.TicketClickedEvent) {
      yield NavigationStates.TicketPageState;
    } else if (event == NavigationEvents.LiveClickedEvent) {
      yield NavigationStates.LiveScreenState;
    } else if (event == NavigationEvents.StereoClickedEvent) {
      yield NavigationStates.StereoScreenState;
    } else if (event == NavigationEvents.VotingClickedEvent) {
      yield NavigationStates.VotingScreenState;
    } else if (event == NavigationEvents.EducationClickedEvent) {
      yield NavigationStates.EducationScreenState;
    } else if (event == NavigationEvents.PostDetailClickEvent) {
      yield NavigationStates.PostDetailScreenState;
    } else if (event == NavigationEvents.SearchPageClickEvent) {
      yield NavigationStates.SearchPageScreenState;
    }
    // Handle other events...
  }
}
