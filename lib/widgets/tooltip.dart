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
  String textColor = null;
  String backgroundColor;
  int id;
  double cornerRadius;
  double textSize = 0.0;
  double textPadding = 0.0;
  double arrowWidth = 0.0;
  double arrowHeight = 0.0;
  double toolTipWidth = 0.0;
  String imageUrl;

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
      cornerRadius = routeArgs['cornerRadius'];
      toolTipWidth = routeArgs['toolTipWidth'];
      imageUrl= routeArgs['imageUrl'];
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
                        tooltipPadding: EdgeInsets.all(textPadding),
                        textSize: textSize,
                        textColorHex: textColor,
                        backgroundColorHex: backgroundColor,
                        cornerRadius: cornerRadius,
                        arrowHeight: arrowHeight,
                        arrowWidth: arrowWidth,
                        toolTipWidth: toolTipWidth,
                        imageUrl: imageUrl,
                      )
                    : ButtonWidget(
                        title: 'Button 1',
                        onPressed: () {},
                      ),
                id == 2
                    ? ToolTipButtonWidget(
                        message: title,
                        buttonName: 'Button 2',
                        tooltipPadding: EdgeInsets.all(textPadding),
                        textSize: textSize,
                        textColorHex: textColor,
                        backgroundColorHex: backgroundColor,
                        cornerRadius: cornerRadius,
                        arrowHeight: arrowHeight,
                        arrowWidth: arrowWidth,
                        toolTipWidth: toolTipWidth,
                        imageUrl: imageUrl,
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
                    tooltipPadding: EdgeInsets.all(textPadding),
                    textSize: textSize,
                    textColorHex: textColor,
                    backgroundColorHex: backgroundColor,
                    cornerRadius: cornerRadius,
                    arrowHeight: arrowHeight,
                    arrowWidth: arrowWidth,
                    toolTipWidth: toolTipWidth,
                    imageUrl: imageUrl,
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
                        tooltipPadding: EdgeInsets.all(textPadding),
                        imageUrl: imageUrl,
                        buttonName: 'Button 4',
                        textSize: textSize,
                        textColorHex: textColor,
                        backgroundColorHex: backgroundColor,
                        cornerRadius: cornerRadius,
                        arrowHeight: arrowHeight,
                        arrowWidth: arrowWidth,
                        toolTipWidth: toolTipWidth,
                      )
                    : ButtonWidget(
                        title: 'Button 4',
                        onPressed: () {},
                      ),
                id == 5
                    ? ToolTipButtonWidget(
                        message: title,
                        tooltipPadding: EdgeInsets.all(textPadding),
                        textSize: textSize,
                        buttonName: 'Button 5',
                        textColorHex: textColor,
                        backgroundColorHex: backgroundColor,
                        cornerRadius: cornerRadius,
                        arrowHeight: arrowHeight,
                        arrowWidth: arrowWidth,
                        toolTipWidth: toolTipWidth,
                        imageUrl: imageUrl,
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
