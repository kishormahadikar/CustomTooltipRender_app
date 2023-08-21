import 'package:flutter/material.dart';
import 'package:plotline_assignment/widgets/button.dart';

class TooltipButton extends StatefulWidget {
  static const routename = '/tooltop';
  @override
  State<TooltipButton> createState() => _TooltipButtonState();
}

class _TooltipButtonState extends State<TooltipButton> {
  final GlobalKey _tooltipKey = GlobalKey();
  bool _isTooltipVisible = false;

  OverlayEntry _overlayEntry;

  void _toggleTooltip() {
    setState(() {
      _isTooltipVisible = !_isTooltipVisible;

      if (_isTooltipVisible) {
        _createOverlayEntry();
      } else {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
  }

  void _createOverlayEntry() {
    final renderBox =
        _tooltipKey.currentContext.findRenderObject() as RenderBox;

    final offset = renderBox.localToGlobal(
      renderBox.size.center(Offset.zero),
      ancestor: context.findRenderObject(),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return PositionedTooltip(
          child: Text('This is a tooltip'),
          targetOffset: offset,
        );
      },
    );
    Overlay.of(context)?.insert(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height:MediaQuery.of(context).size.height*0.10,
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(title: 'Button 1',onPressed: _toggleTooltip),
             ButtonWidget(title: 'Button 2',onPressed: _toggleTooltip),
            ],
            ),
             SizedBox(
              height:MediaQuery.of(context).size.height*0.3,
            ),
            ButtonWidget(title: 'Button 3',onPressed: _toggleTooltip),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.37,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ButtonWidget(title: 'Button 4',onPressed: _toggleTooltip),
              ButtonWidget(title: 'Button 5',onPressed: _toggleTooltip),
              ],
            ),
            Container(
              key: _tooltipKey, //find the render object
              child: SizedBox.shrink(), //empty widget
            ),
          ],
        ),
      ),
    );
  }
}

class PositionedTooltip extends StatelessWidget {
  final Widget child;
  final Offset targetOffset;

  PositionedTooltip({@required this.child, @required this.targetOffset});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: targetOffset.dy + -200,
      left: targetOffset.dx,
      child: Material(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey,
          child: child,
        ),
      ),
    );
  }
}
