import 'package:_2geda/SideBar/sidebar_layout.dart';
import 'package:flutter/material.dart';

class AdvertPreview extends StatelessWidget {
  const AdvertPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Advert Preview',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 410,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: const Color.fromARGB(255, 226, 226, 226),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Advert Title",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("2023 General election",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Category",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Homepage leaderboard",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Duration",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("1 month",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Advert image",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("assets/banner2.png")),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Cost",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("#98345",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SideBarLayout(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4e0ca2),
                minimumSize: const Size(300, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Pay now",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
