import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            enabled: false,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Choose Options',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'milk1',
            child: ListTile(
              title: Text('Milk Option 1'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'milk2',
            child: ListTile(
              title: Text('Milk Option 2'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'milk3',
            child: ListTile(
              title: Text('Milk Option 3'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'sugar1',
            child: ListTile(
              title: Text('Sugar Option 1'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'sugar2',
            child: ListTile(
              title: Text('Sugar Option 2'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'sugar3',
            child: ListTile(
              title: Text('Sugar Option 3'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'size1',
            child: ListTile(
              title: Text('Size Option 1'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'size2',
            child: ListTile(
              title: Text('Size Option 2'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'size3',
            child: ListTile(
              title: Text('Size Option 3'),
              leading: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
        ];
      },
      child: Icon(
        CupertinoIcons.add,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
