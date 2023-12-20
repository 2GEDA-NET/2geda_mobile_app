import 'package:flutter/material.dart';

class TstGrid extends StatelessWidget {
  const TstGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
              ';oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo'),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: GridView.builder(
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                // shrinkWrap: true,
                // cacheExtent: 2.0,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 2.5,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: SizedBox(
                      height: 12,
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text('Item $index'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
