import 'package:fats_client/constants.dart';
import 'package:flutter/material.dart';

class FatsWidget extends StatelessWidget {
  const FatsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.36,
      decoration: BoxDecoration(
        color: Constant.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Constant.primaryColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          Text(
            "FATS",
            style: TextStyle(
              fontSize: 80,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Expanded(
            child: Text(
              "Fixed Asset Tracking Software v.2.0",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
