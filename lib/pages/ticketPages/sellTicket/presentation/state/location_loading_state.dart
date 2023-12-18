import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LocationLoadingState extends StatelessWidget {
  LocationLoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:
              Container(decoration: const BoxDecoration(color: Colors.white)),
        ));
  }
}
