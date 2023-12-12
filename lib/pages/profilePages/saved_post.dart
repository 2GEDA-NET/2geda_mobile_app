import 'package:_2geda/SideBar/bloc_navigation/navigation_bloc.dart';
import 'package:_2geda/data/data.dart';
import 'package:_2geda/pages/widgets/posts/post_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedPosts extends StatelessWidget {
  const SavedPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (context) =>
          NavigationBloc(), // Replace with your NavigationBloc initialization
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: const Text(
              'Saved Posts',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/2geda-purple.png'),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: posts.map((post) => PostContainer(post: post)).toList(),
            ),
          )),
    );
  }
}
