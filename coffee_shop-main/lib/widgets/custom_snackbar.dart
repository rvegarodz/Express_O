import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<dynamic>?> showCustomSnackBar(
    BuildContext context, List<List<String>> options, User? user, String time) {
  List<List<String>> selectedOptions = List.generate(options.length, (_) => []);
  int currentStep = 0;

  return showModalBottomSheet<List<dynamic>?>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            if (currentStep > 0) {
                              setState(() {
                                currentStep--;
                              });
                            }
                          },
                        ),
                        Spacer(),
                        Text(
                          'Choose Options',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        if (currentStep < 2)
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              if (currentStep < 2) {
                                setState(() {
                                  currentStep++;
                                });
                              }
                            },
                          ),
                        if (currentStep == 2)
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              Navigator.pop(context, selectedOptions);
                            },
                          ),
                      ]),
                ),
                Divider(),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: ListView(
                      children: options[currentStep].map(
                        (option) {
                          return RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: selectedOptions[currentStep].isNotEmpty
                                ? selectedOptions[currentStep][0]
                                : null,
                            onChanged: (value) {
                              setState(
                                () {
                                  selectedOptions[currentStep].clear();
                                  selectedOptions[currentStep].add(value!);
                                },
                              );
                            },
                            activeColor: Colors.blue,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  ).then((value) {
    return value; // Return the selectedOptions list
  });
}
