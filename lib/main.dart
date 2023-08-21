import 'package:flutter/material.dart';
import 'package:plotline_assignment/page2.dart';
import 'package:plotline_assignment/widgets/tooltip.dart';

void main() {
  runApp(MyApp());
}

class ButtonItem {
  final int id;
  final String title;

  ButtonItem(this.id, this.title);
}

final List<ButtonItem> buttonItems = [
  ButtonItem(1, 'Button 1'),
  ButtonItem(2, 'Button 2'),
  ButtonItem(3, 'Button 3'),
  ButtonItem(4, 'Button 4'),
  ButtonItem(5, 'Button 5'),
];

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page1(),
      routes: {
        TooltipButton.routename: (context) => TooltipButton(),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Target element',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  DropdownFormExample(buttonItems: buttonItems),
                  const Text(
                    'Tooltip Text',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  TextFormField(
                    maxLength: 100,
                    decoration: const InputDecoration(labelText: 'Input'),
                  ),
                  Row(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(TooltipButton.routename);
                    },
                    child: const Text("Render Tooltip"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownFormExample extends StatefulWidget {
  final List<ButtonItem> buttonItems;

  DropdownFormExample({@required this.buttonItems});

  @override
  _DropdownFormExampleState createState() => _DropdownFormExampleState();
}

class _DropdownFormExampleState extends State<DropdownFormExample> {
  ButtonItem _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<ButtonItem>(
        value: _selectedItem,
        onChanged: (value) {
          setState(() {
            _selectedItem = value;
          });
        },
        items: widget.buttonItems.map((ButtonItem item) {
          return DropdownMenuItem<ButtonItem>(
            value: item,
            child: Text(item.title),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Select an element',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
