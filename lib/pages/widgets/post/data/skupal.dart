import 'package:flutter/material.dart';

class Skupl extends StatefulWidget {
  const Skupl({super.key});

  @override
  State<Skupl> createState() => _SkuplState();
}

class _SkuplState extends State<Skupl> {
  final List<TextEditingController> controllers = [];
  TextEditingController controller = TextEditingController();
  OurList ourList = OurList();

  @override
  Widget build(BuildContext context) {
    controllers.addAll(List.generate(
        ourList.value.length, (index) => TextEditingController()));
    return Scaffold(
      body: Column(children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_, i) {
              return ListTile(
                title: Text(items[i]),
                onTap: () {
                  ourList.addtoList(items[i]);
                  print(ourList.value);
                },
              );
            }),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
            valueListenable: ourList,
            builder: (context, t, u) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: ourList.value.length,
                  itemBuilder: (_, i) {
                    return TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ourList.removeinList(i);
                            },
                          ),
                          hintText: ourList.value[i],
                          border: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    );
                  });
            }),
      ]),
    );
  }
}

//! Creating type Aliases
typedef ViewModel<T> = ValueNotifier<T>;

//! My PlayGround
List items = ['ddd', 'lllll', 'mmm'];

class OurList extends ViewModel<List> {
  OurList() : super([]);

  void addtoList(String name) {
    value.add(name);
    notifyListeners();
  }

  void removeinList(int i) {
    value.removeAt(i);
    notifyListeners();
  }
}
