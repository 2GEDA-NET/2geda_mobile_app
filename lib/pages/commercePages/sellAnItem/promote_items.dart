// account_screen.dart

import 'package:_2geda/pages/commercePages/sellAnItem/promotion_preview.dart';
import 'package:flutter/material.dart';

class PromoteItem extends StatefulWidget {
  const PromoteItem({super.key});

  @override
  State<PromoteItem> createState() => _PromoteItemState();
}

class _PromoteItemState extends State<PromoteItem> {
  int? selectedPlan;
  final TextStyle activeTextStyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
      
  final TextStyle activeLabelTextStyle = const TextStyle(
      color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500);
  final TextStyle inactiveTextStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
      
  final TextStyle inactiveLabelTextStyle = const TextStyle(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500);
  final Color activeBackgroundColor =
      const Color(0xff4e0ca2); // Change to your desired color
  final Color inactiveBackgroundColor = const Color(0x19000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Promote Sale',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.thunderstorm),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sell faster when you promote your item",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text("We’ve got amazing plans for you",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPromotionRadioContainer(1, 'Dialy \nPlan', '10000'),
                    _buildPromotionRadioContainer(2, '3 days \nPlan', '10000'),
              
                      ],
                    ),
                    const SizedBox(height: 20,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPromotionRadioContainer(3, '1 week \nPlan', '10000'),
                _buildPromotionRadioContainer(4, '1 month \nPlan', '10000'),
              
                  ],
                ),
                const SizedBox(height: 20,),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPromotionRadioContainer(5, '3 month \nPlan', '10000'),
                    _buildPromotionRadioContainer(6, '1 year \nPlan', '10000'),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PromotionPreviewPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Proceed",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionRadioContainer(int value, String label, String price) {
    final isSelected = selectedPlan == value;
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 168,
      height: 132,
      decoration: BoxDecoration(
          color: isSelected ? activeBackgroundColor : inactiveBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffff8811), Color(0xffe84646)],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: isSelected ? activeLabelTextStyle : inactiveLabelTextStyle,
              ),
              const SizedBox(height: 20,),
              Text(
                '\$$price',
                style: isSelected ? activeTextStyle : inactiveTextStyle,

              ),
            ],
          ),
          Radio(
            value: value,
            groupValue: selectedPlan,
            activeColor: Colors.white,
            onChanged: (int? newValue) {
              setState(() {
                selectedPlan = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
