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
  int _selectedItemId; //added
  String _tooltipText = ''; //added
  String _textColor = ''; //added
  String _backgroundColor = ''; //added
  double _textSize = 0.0; //added
  double _textPadding = 0.0; //added
  double _cornerRadius = 0.0; //ADDED
  double _tooltipWidth = 0.0; //added
  double _arrowWidth = 0.0; //added
  double _arrowHeight = 0.0; //added
  String _imageUrl; //added

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.height * 0.05),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const Text(
                  'Tooltip Text',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextFormField(
                  maxLength: 100,
                  decoration: const InputDecoration(labelText: 'Input'),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          const Text(
                            'Text Size',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                              decoration: const InputDecoration(hintText: '20'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _textSize = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          const Text(
                            'Padding',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                              decoration: const InputDecoration(hintText: '3'),
                              onChanged: (value) {
                                setState(() {
                                  _textPadding = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                const Text(
                  'Text Color',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Add "0xff" followed by color hex code'),
                  onChanged: (value) {
                    setState(() {
                      _textColor = value;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Text(
                  'Background Color',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Add "0xff" followed by color hex code'),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          const Text(
                            'Corner Radius',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                              decoration: const InputDecoration(hintText: '20'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _cornerRadius = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          const Text(
                            'Tooltip Width',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                              decoration: const InputDecoration(hintText: '3'),
                              onChanged: (value) {
                                setState(() {
                                  _tooltipWidth = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          const Text(
                            'Arrow Width',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                              decoration: const InputDecoration(hintText: '20'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _arrowWidth = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          const Text(
                            'ArrowHeight',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                              decoration: const InputDecoration(hintText: '3'),
                              onChanged: (value) {
                                setState(() {
                                  _arrowHeight = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                const Text(
                  'Image URL',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Add Image URL'),
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
                          'textsize': _textSize==0.0?25.0:_textSize,
                          'padding': _textPadding,
                          'textColor': _textColor,
                          'backgroundColor': _backgroundColor,
                          'arrowWidth': _arrowWidth==0.0?20.5:_arrowWidth,
                          'arrowHeight': _arrowHeight==0.0?15.5:_arrowHeight,
                          'cornerRadius':_cornerRadius==0.0?10.0:_cornerRadius,
                          'toolTipWidth' : _tooltipWidth==0.0?111.1:_tooltipWidth,
                          'imageUrl' : _imageUrl
                        });
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
          widget.onItemSelected(_selectedItem.id); // Call the callback here
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
