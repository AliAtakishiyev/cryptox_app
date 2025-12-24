import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 16),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                "Cryptox",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: .bold,
                ),
              ),
          
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh, 
                  color: Color(0xff808999)
                  ),
              ),
            ],
          ),
        ),
    
        Container(height: 1,color: Color(0xff313540),)
      ],
    );
  }
}
