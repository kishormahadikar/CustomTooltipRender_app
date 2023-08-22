import 'package:flutter/material.dart';
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

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int _selectedItemId;
  String _tooltipText = '';
  String _textColor = '';
  String _backgroundColor = '';
  double _textSize = 0.0;
  double _textPadding = 0.0;
  double _cornerRadius = 0.0;
  double _tooltipWidth = 0.0;
  double _arrowWidth = 0.0;
  double _arrowHeight = 0.0;
  String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                const Text(
                  'Target element',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                DropDownFormItem(
                  buttonItems: buttonItems,
                  onItemSelected: (int itemId) {
                    setState(() {
                      _selectedItemId = itemId;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                buildTextInputField(
                  context: context,
                  label: 'Tooltip Text',
                  labelText: 'Input',
                  onChanged: (value) {
                    setState(() {
                      _tooltipText = value;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildNumericInputField(
                      context: context,
                      label: 'Text Size',
                      hintText: '20',
                      onChanged: (value) {
                        setState(() {
                          _textSize = double.parse(value);
                        });
                      },
                    ),
                    buildNumericInputField(
                      context: context,
                      label: 'Padding',
                      hintText: '3',
                      onChanged: (value) {
                        setState(() {
                          _textPadding = double.parse(value);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                buildTextInputField(
                  context: context,
                  label: 'Text Color',
                  labelText: 'Add "0xff" followed by color hex code',
                  onChanged: (value) {
                    setState(() {
                      _textColor = value;
                    });
                  },
                ),
                buildTextInputField(
                  context: context,
                  label: 'Background Color',
                  labelText: 'Add "0xff" followed by color hex code',
                  onChanged: (value) {
                    setState(() {
                      _backgroundColor = value;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildNumericInputField(
                      context: context,
                      label: 'Corner Radius',
                      hintText: '20',
                      onChanged: (value) {
                        setState(() {
                          _cornerRadius = double.parse(value);
                        });
                      },
                    ),
                    buildNumericInputField(
                      context: context,
                      label: 'Tooltip Width',
                      hintText: '3',
                      onChanged: (value) {
                        setState(() {
                          _tooltipWidth = double.parse(value);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildNumericInputField(
                      context: context,
                      label: 'Arrow Width',
                      hintText: '20',
                      onChanged: (value) {
                        setState(() {
                          _arrowWidth = double.parse(value);
                        });
                      },
                    ),
                    buildNumericInputField(
                      context: context,
                      label: 'Arrow Height',
                      hintText: '3',
                      onChanged: (value) {
                        setState(() {
                          _arrowHeight = double.parse(value);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                buildTextInputField(
                  context: context,
                  label: 'Image URL',
                  labelText: 'Add Image URL',
                  onChanged: (value) {
                    setState(() {
                      _imageUrl = value;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      TooltipButton.routename,
                      arguments: {
                        'id': _selectedItemId,
                        'title': _tooltipText,
                        'textsize': _textSize == 0.0 ? 25.0 : _textSize,
                        'padding': _textPadding,
                        'textColor': _textColor,
                        'backgroundColor': _backgroundColor,
                        'arrowWidth': _arrowWidth == 0.0 ? 20.5 : _arrowWidth,
                        'arrowHeight': _arrowHeight == 0.0 ? 15.5 : _arrowHeight,
                        'cornerRadius': _cornerRadius == 0.0 ? 10.0 : _cornerRadius,
                        'toolTipWidth': _tooltipWidth == 0.0 ? 111.1 : _tooltipWidth,
                        'imageUrl': _imageUrl,
                      },
                    );
                  },
                  child: const Text("Render Tooltip"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build text input fields
  Widget buildTextInputField({
    BuildContext context,
    String label,
    String labelText,
    Function(String) onChanged,
  }) {
    return Column(
      children: [
         Text(
          label,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: labelText),
          onChanged: onChanged,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }

  // Helper function to build numeric input fields
  Widget buildNumericInputField({
    BuildContext context,
    String label,
    String hintText,
    Function(String) onChanged,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        children: [
           Text(
            label,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: hintText),
            keyboardType: TextInputType.number,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class DropDownFormItem extends StatefulWidget {
  final List<ButtonItem> buttonItems;
  final ValueChanged<int> onItemSelected;

  DropDownFormItem({@required this.buttonItems, @required this.onItemSelected});

  @override
  _DropDownFormItemState createState() => _DropDownFormItemState();
}

class _DropDownFormItemState extends State<DropDownFormItem> {
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
          widget.onItemSelected(_selectedItem.id);
        },
        items: widget.buttonItems.map((ButtonItem item) {
          return DropdownMenuItem<ButtonItem>(
            value: item,
            child: Text(item.title),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Select an element',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

