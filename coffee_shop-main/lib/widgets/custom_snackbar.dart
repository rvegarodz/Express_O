import 'package:flutter/material.dart';

<<<<<<< HEAD
void showCustomSnackBar(BuildContext context, List<String> options,
    Function(List<String>) onOptionsSelected) {
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
                      onOptionsSelected(selectedOptions);
                    },
                  ),
                ],
              ),
            );
          },
        );
      });
=======
class CustomSnackBar extends StatefulWidget {
  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  int currentStep = 0;
  String? selectedMilkOption;
  String? selectedSugarOption;
  String? selectedSizeOption;

  @override
  Widget build(BuildContext context) {
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
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (currentStep < 2) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      // Handle final option selection here
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: buildStepContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStepContent() {
    switch (currentStep) {
      case 0:
        return buildOptionStep(
          'Milk',
          ['Milk Option 1', 'Milk Option 2', 'Milk Option 3'],
          selectedMilkOption,
          (value) {
            setState(() {
              selectedMilkOption = value;
            });
          },
        );
      case 1:
        return buildOptionStep(
          'Sugar',
          ['Sugar Option 1', 'Sugar Option 2', 'Sugar Option 3'],
          selectedSugarOption,
          (value) {
            setState(() {
              selectedSugarOption = value;
            });
          },
        );
      case 2:
        return buildOptionStep(
          'Size',
          ['Size Option 1', 'Size Option 2', 'Size Option 3'],
          selectedSizeOption,
          (value) {
            setState(() {
              selectedSizeOption = value;
            });
          },
        );
      default:
        return Container();
    }
  }

  Column buildOptionStep(
    String title,
    List<String> options,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedValue,
              onChanged: onChanged,
            );
          }).toList(),
        ),
      ],
    );
  }
>>>>>>> 6cc1413aaa2ae45a637634417f2ded4ab5edc252
}
