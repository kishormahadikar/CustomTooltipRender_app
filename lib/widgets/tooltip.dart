import 'package:flutter/material.dart';
import 'package:plotline_assignment/widgets/button.dart';
import 'package:plotline_assignment/widgets/tooltipbutton.dart';

class TooltipButton extends StatefulWidget {
  static const routename = '/tooltop';
  final int selectedItemId;
  final String tooltipText;

  TooltipButton({this.selectedItemId, this.tooltipText});

  @override
  State<TooltipButton> createState() => _TooltipButtonState();
}

class _TooltipButtonState extends State<TooltipButton> {
  final GlobalKey _tooltipKey = GlobalKey();
  var depCheck = false;
  String title;
  String textColor;
  String backgroundColor;
  int id;
  int textSize = 0;
  int textPadding = 0;
  int arrowWidth = 0;
  int arrowHeight = 0;

  void didChangeDependencies() {
    if (!depCheck) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      id = routeArgs['id'];
      title = routeArgs['title'];
      textSize = routeArgs['textsize'];
      textPadding = routeArgs['padding'];
      textColor = routeArgs['textColor'];
      backgroundColor = routeArgs['backgroundColor'];
      arrowWidth = routeArgs['arrowWidth'];
      arrowHeight = routeArgs['arrowHeight'];
      depCheck = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(textSize.toString());
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                id == 1
                    ? ToolTipButtonWidget(
                        message: title,
                        buttonName: 'Button 1',
                      )
                    : ButtonWidget(
                        title: 'Button 1',
                        onPressed: () {},
                      ),
                id == 2
                    ? ToolTipButtonWidget(
                        message: title,
                        buttonName: 'Button 2',
                      )
                    : ButtonWidget(
                        title: 'Button 2',
                        onPressed: () {},
                      ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            id == 3
                ? ToolTipButtonWidget(
                    message: title,
                    buttonName: 'Button 3',
                  )
                : ButtonWidget(
                    title: 'Button 3',
                    onPressed: () {},
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.37,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                id == 4
                    ? ToolTipButtonWidget(
                        message: title,
                        imageUrl:
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                        buttonName: 'Button 4',
                      )
                    : ButtonWidget(
                        title: 'Button 4',
                        onPressed: () {},
                      ),
                id == 5
                    ? ToolTipButtonWidget(
                        message: title,
                        buttonName: 'Button 5',
                      )
                    : ButtonWidget(
                        title: 'Button 5',
                        onPressed: () {},
                      ),
              ],
            ),
            Container(
              key: _tooltipKey,
              child: SizedBox.shrink(),
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
