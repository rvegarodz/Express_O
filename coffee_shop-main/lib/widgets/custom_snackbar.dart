import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffee_shop/db/firebase_services.dart';

void handleOptionsSelected(
    User? user, List<dynamic> selectedOptions, String time) {
  // Do something with the selected options
  FirebaseService.addDescription(user!.uid, selectedOptions, time);
  print(selectedOptions);
}

void showCustomSnackBar(
    BuildContext context, List<String> options, User? user, String time) {
  List<String> selectedOptions = [];

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300,
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
                              // nothing yet
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
                          IconButton(icon: Icon(Icons.add), onPressed: () {})
                        ]),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: options.map(
                      (option) {
                        return RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: selectedOptions.isNotEmpty
                              ? selectedOptions[0]
                              : null,
                          onChanged: (value) {
                            setState(() {
                              selectedOptions.clear();
                              selectedOptions.add(value!);
                            });
                          },
                          activeColor: Colors.blue,
                        );
                      },
                    ).toList(),
                  ),
                  ElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      Navigator.pop(context);
                      handleOptionsSelected(user, selectedOptions, time);
                    },
                  ),
                ],
              ),
            );
          },
        );
      });
}
