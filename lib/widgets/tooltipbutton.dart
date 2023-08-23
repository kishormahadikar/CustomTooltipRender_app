import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plotline_assignment/widgets/button.dart';

class ToolTipButtonWidget extends StatefulWidget {
  final String message;
  final String imageUrl;
  final double cornerRadius;
  final String buttonName;
  final double textSize;
  final String textColorHex;
  final String backgroundColorHex;
  final EdgeInsets tooltipPadding;
  final double arrowWidth;
  final double arrowHeight;
  final double toolTipWidth;
  final bool preferredBelow;

  const ToolTipButtonWidget({
    Key key,
    this.imageUrl,
    this.cornerRadius,
    @required this.message,
    this.buttonName,
    this.textSize,
    this.textColorHex,
    this.backgroundColorHex,
    this.tooltipPadding,
    this.arrowWidth,
    this.arrowHeight,
    this.toolTipWidth,
    this.preferredBelow = true,
  }) : super(key: key);

  @override
  _ToolTipButtonWidgetState createState() => _ToolTipButtonWidgetState();
}

class _ToolTipButtonWidgetState extends State<ToolTipButtonWidget>
    with TickerProviderStateMixin {
  final color = Colors.black38;
  GlobalKey key;
  Offset _offset;
  Size _size;
  OverlayEntry overlayEntry;
  var depCheck = false;
  AnimationController _controller;
  Timer _tooltipTimer;
  double _textSize;

  @override
  void didChangeDependencies() {
    if (!depCheck) {
      key = LabeledGlobalKey(widget.message);
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 300));

      _textSize = widget.textSize == 0.0 ||
              widget.textSize == null ||
              (!widget.textSize.isNaN)
          ? 20
          : widget.textSize;
      depCheck = true;
    }
    super.didChangeDependencies();
  }

  void getWidgetDetails() {
    final renderBox = key.currentContext.findRenderObject() as RenderBox;
    _size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    _offset = offset;
  }

  OverlayEntry _makeOverlay(BuildContext context) {
    double arrowTop = widget.preferredBelow
        ? _offset.dy + 20
        : _offset.dy - widget.arrowHeight - MediaQuery.of(context).size.height * 0.7;

    double tooltipTop = widget.preferredBelow
        ? arrowTop + widget.arrowHeight
        : arrowTop - widget.arrowHeight;

    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: widget.preferredBelow ? null : MediaQuery.of(context).size.height*0.25 - tooltipTop,
        top: widget.preferredBelow ? tooltipTop : null,
        left: _offset.dx - (widget.toolTipWidth / 2),
        width: _size.width + widget.toolTipWidth,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 0.9).animate(
              CurvedAnimation(parent: _controller, curve: Curves.bounceOut)),
          child: Column(
            children: [
              widget.preferredBelow? Align(
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ArrowClip(isDownArrow: widget.preferredBelow),
                  child: Container(
                    height: widget.arrowHeight,
                    width: widget.arrowWidth,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                    ),
                  ),
                ),
              ) : SizedBox(),
              Material(
                borderRadius: BorderRadius.circular(widget.cornerRadius),
                color: widget.backgroundColorHex.isEmpty
                    ? Colors.black54
                    : Color(int.parse(widget.backgroundColorHex)),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(widget.cornerRadius),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: widget.tooltipPadding ?? EdgeInsets.all(15),
                        child: Text(
                          widget.message,
                          style: TextStyle(
                              color: widget.textColorHex.isEmpty
                                  ? Colors.white
                                  : Color(int.parse(widget.textColorHex)),
                              fontSize: widget.textSize),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      widget.imageUrl == null
                          ? SizedBox()
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                widget.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              !widget.preferredBelow? Align(
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: ArrowClip(isDownArrow: widget.preferredBelow),
                  child: Container(
                    height: widget.arrowHeight,
                    width: widget.arrowWidth,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                    ),
                  ),
                ),
              ) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imageUrl);
    return InkWell(
      key: key,
      child: ButtonWidget(title: widget.buttonName, onPressed: () {}),
      onTap: () {},
      onLongPress: () {
        getWidgetDetails();
        overlayEntry = _makeOverlay(context);
        Overlay.of(context).insert(overlayEntry);
        _controller.forward();
        _tooltipTimer = Timer(Duration(seconds: 20), () {
          _controller.reverse();
          overlayEntry.remove();
        });
      },
    );
  }

  @override
  void dispose() {
    _tooltipTimer?.cancel();
    super.dispose();
  }
}

class ArrowClip extends CustomClipper<Path> {
  final bool isDownArrow;

  ArrowClip({this.isDownArrow = true});

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (isDownArrow) {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
