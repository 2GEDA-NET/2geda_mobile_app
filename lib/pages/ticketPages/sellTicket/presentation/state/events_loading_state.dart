import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecentEventLoadingState extends StatelessWidget {
  int? itemCount;
  RecentEventLoadingState({
    this.itemCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: itemCount, // Number of shimmer items
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
            ),
            title: Container(
              height: 15.0,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 10.0,
              width: double.infinity,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
