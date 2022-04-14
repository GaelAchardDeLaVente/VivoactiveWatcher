import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steps_api/steps_api.dart';

class StepsCard extends StatelessWidget {
  final StepData step;

  const StepsCard({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("EEEE", 'fr').format(step.date),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12.0),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: "Vous avez fait "),
                  TextSpan(
                      text: "${step.stepsNumber}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      )),
                  TextSpan(text: " pas.")
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
    );
  }
}
