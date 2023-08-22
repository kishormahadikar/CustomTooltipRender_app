// import 'package:flutter/material.dart';

// class ToolTipButtonWidget extends StatefulWidget {
//   final String message;
//   final String buttonName;
//   final Function onPressed;

//   const ToolTipButtonWidget({
//     Key key,
//     @required this.buttonName,
//     @required this.message,
//     this.onPressed,
//   }) : super(key: key);

//   @override
//   _ToolTipButtonWidgetState createState() => _ToolTipButtonWidgetState();
// }

// class _ToolTipButtonWidgetState extends State<ToolTipButtonWidget>
//     with TickerProviderStateMixin {
//   final Color tooltipColor = Colors.white;
//   GlobalKey _key;
//   OverlayEntry _overlayEntry;
//   AnimationController _controller;
//   bool _isHovered = false;

//   @override
//   void initState() {
//     _key = LabeledGlobalKey(widget.message);
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       key: _key,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.all(8),
//           backgroundColor: Colors.white,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//           ),
//         ),
//         child: Text('gulu',
//           //widget.buttonName,
//           style: const TextStyle(color: Colors.black, fontSize: 23),
//         ),
//         onPressed: widget.onPressed,
//       ),
//       onTap: () {
//         if (_isHovered) {
//           _hideToolTip();
//         } else {
//           _showToolTip();
//         }
//       },
//       onTapCancel: () {
//         _hideToolTip();
//       },
//       onTapDown: (_) {
//         _isHovered = true;
//       },
//       onTapUp: (_) {
//         _isHovered = false;
//       },
//     );
//   }

//   void _showToolTip() {
//     final renderBox = _key.currentContext.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//     final offset = renderBox.localToGlobal(Offset.zero);

//     _overlayEntry = _createOverlay(offset, size);
//     Overlay.of(context).insert(_overlayEntry);

//     _controller.forward();
//   }

// void _hideToolTip() {
//   _controller.reverse();
//   if (_overlayEntry != null) {
//     _overlayEntry.remove();
//     _overlayEntry = null; // Reset _overlayEntry to null after removal
//   }
// }

//   OverlayEntry _createOverlay(Offset offset, Size size) {
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         top: offset.dy + 40,
//         left: offset.dx - 25,
//         width: size.width + 50,
//         child: ScaleTransition(
//           scale: Tween<double>(begin: 0.5, end: 0.9).animate(
//             CurvedAnimation(
//               parent: _controller,
//               curve: Curves.bounceOut,
//             ),
//           ),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: ClipPath(
//                   clipper: _ArrowPointer(),
//                   child: Container(
//                     height: 10,
//                     width: 15,
//                     decoration: BoxDecoration(
//                       color: tooltipColor,
//                     ),
//                   ),
//                 ),
//               ),
//               Material(
//                 color: Colors.transparent,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: tooltipColor,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   padding: const EdgeInsets.all(4),
//                   child: Text(
//                     widget.message,
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ArrowPointer extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();

//     path.moveTo(0, size.height);
//     path.lineTo(size.width / 2, 0);
//     path.lineTo(size.width, size.height);

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/src/material/feedback.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:flutter/src/material/tooltip_theme.dart';
import 'package:flutter/src/material/tooltip_visibility.dart';
import 'package:plotline_assignment/widgets/button.dart';

typedef TooltipTriggeredCallback = void Function();

class ToolTipButtonWidget extends StatefulWidget {
  const ToolTipButtonWidget({
    this.key,
    this.message,
    this.buttonName,
    this.imageUrl,
    this.richMessage,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.triggerMode,
    this.enableFeedback,
    this.onTriggered,
    this.child,
  })  : assert((message == null) != (richMessage == null),
            'Either `message` or `richMessage` must be specified'),
        assert(
          richMessage == null || textStyle == null,
          'If `richMessage` is specified, `textStyle` will have no effect. '
          'If you wish to provide a `textStyle` for a rich tooltip, add the '
          '`textStyle` directly to the `richMessage` InlineSpan.',
        );
  final Key key;
  final String buttonName;
  final String message;
  final String imageUrl;
  final InlineSpan richMessage;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double verticalOffset;
  final bool preferBelow;
  final bool excludeFromSemantics;
  final Widget child;
  final Decoration decoration;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Duration waitDuration;
  final Duration showDuration;
  final TooltipTriggerMode triggerMode;
  final bool enableFeedback;
  final TooltipTriggeredCallback onTriggered;

  static final List<TooltipState> _openedTooltips = <TooltipState>[];
  static void _concealOtherTooltips(TooltipState current) {
    if (_openedTooltips.isNotEmpty) {
      // Avoid concurrent modification.
      final List<TooltipState> openedTooltips = _openedTooltips.toList();
      for (final TooltipState state in openedTooltips) {
        if (state == current) {
          continue;
        }
        state._concealTooltip();
      }
    }
  }

  static void _revealLastTooltip() {
    if (_openedTooltips.isNotEmpty) {
      _openedTooltips.last._revealTooltip();
    }
  }

  static bool dismissAllToolTips() {
    if (_openedTooltips.isNotEmpty) {
      // Avoid concurrent modification.
      final List<TooltipState> openedTooltips = _openedTooltips.toList();
      for (final TooltipState state in openedTooltips) {
        state._dismissTooltip(immediately: true);
      }
      return true;
    }
    return false;
  }

  State<ToolTipButtonWidget> createState() => TooltipState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty(
      'message',
      message,
      showName: message == null,
      defaultValue: message == null ? null : kNoDefaultValue,
    ));
    properties.add(StringProperty(
      'imageUrl',
      imageUrl,
      showName: imageUrl == null,
      defaultValue: imageUrl == null ? null : kNoDefaultValue,
    ));
    properties.add(StringProperty(
      'buttonName',
      buttonName,
      showName: buttonName == null,
      defaultValue: buttonName == null ? null : kNoDefaultValue,
    ));
    properties.add(StringProperty(
      'richMessage',
      richMessage?.toPlainText(),
      showName: richMessage == null,
      defaultValue: richMessage == null ? null : kNoDefaultValue,
    ));
    properties.add(DoubleProperty('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin,
        defaultValue: null));
    properties.add(
        DoubleProperty('vertical offset', verticalOffset, defaultValue: null));
    properties.add(FlagProperty('position',
        value: preferBelow, ifTrue: 'below', ifFalse: 'above', showName: true));
    properties.add(FlagProperty('semantics',
        value: excludeFromSemantics, ifTrue: 'excluded', showName: true));
    properties.add(DiagnosticsProperty<Duration>('wait duration', waitDuration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>('show duration', showDuration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TooltipTriggerMode>(
        'triggerMode', triggerMode,
        defaultValue: null));
    properties.add(FlagProperty('enableFeedback',
        value: enableFeedback, ifTrue: 'true', showName: true));
    properties.add(DiagnosticsProperty<TextAlign>('textAlign', textAlign,
        defaultValue: null));
  }
}

class TooltipState extends State<ToolTipButtonWidget>
    with SingleTickerProviderStateMixin {
  static const double _defaultVerticalOffset = 24.0;
  static const bool _defaultPreferBelow = true;
  static const EdgeInsetsGeometry _defaultMargin = EdgeInsets.zero;
  static const Duration _fadeInDuration = Duration(milliseconds: 150);
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);
  static const Duration _defaultShowDuration = Duration(milliseconds: 1500);
  static const Duration _defaultHoverShowDuration = Duration(milliseconds: 100);
  static const Duration _defaultWaitDuration = Duration.zero;
  static const bool _defaultExcludeFromSemantics = false;
  static const TooltipTriggerMode _defaultTriggerMode =
      TooltipTriggerMode.longPress;
  static const bool _defaultEnableFeedback = true;
  static const TextAlign _defaultTextAlign = TextAlign.start;

  double _height;
  EdgeInsetsGeometry _padding;
  EdgeInsetsGeometry _margin;
  Decoration _decoration;
  TextStyle _textStyle;
  TextAlign _textAlign;
  double _verticalOffset;
  bool _preferBelow;
  bool _excludeFromSemantics;
  AnimationController _controller;
  OverlayEntry _entry;
  Timer _dismissTimer;
  Timer _showTimer;
  Duration _showDuration;
  Duration _hoverShowDuration;
  Duration _waitDuration;
  bool _mouseIsConnected;
  bool _pressActivated = false;
  TooltipTriggerMode _triggerMode;
  bool _enableFeedback;
  bool _isConcealed;
  bool _forceRemoval;
  bool _visible;
  String get _tooltipMessage =>
      widget.message ?? widget.richMessage.toPlainText();
  String get _tooltipImageUrl =>
      widget.imageUrl ?? widget.richMessage.toPlainText();

  @override
  void initState() {
    super.initState();
    _isConcealed = false;
    _forceRemoval = false;
    _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
    // Listen to see when a mouse is added.
    RendererBinding.instance.mouseTracker
        .addListener(_handleMouseTrackerChange);
    // Listen to global pointer events so that we can hide a tooltip immediately
    // if some other control is clicked on.
    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _visible = TooltipVisibility.of(context);
  }

  // https://material.io/components/tooltips#specs
  double _getDefaultTooltipHeight() {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 24.0;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return 32.0;
    }
  }

  EdgeInsets _getDefaultPadding() {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0);
    }
  }

  double _getDefaultFontSize() {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 12.0;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return 14.0;
    }
  }

  void _handleMouseTrackerChange() {
    if (!mounted) {
      return;
    }
    final bool mouseIsConnected =
        RendererBinding.instance.mouseTracker.mouseIsConnected;
    if (mouseIsConnected != _mouseIsConnected) {
      setState(() {
        _mouseIsConnected = mouseIsConnected;
      });
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed &&
        (_forceRemoval || !_isConcealed)) {
      _removeEntry();
    }
  }

  void _dismissTooltip({bool immediately = false}) {
    _showTimer?.cancel();
    _showTimer = null;
    if (immediately) {
      _removeEntry();
      return;
    }
    _forceRemoval = true;
    if (_pressActivated) {
      _dismissTimer ??= Timer(_showDuration, _controller.reverse);
    } else {
      _dismissTimer ??= Timer(_hoverShowDuration, _controller.reverse);
    }
    _pressActivated = false;
  }

  void _showTooltip({bool immediately = false}) {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    if (immediately) {
      ensureTooltipVisible();
      return;
    }
    _showTimer ??= Timer(_waitDuration, ensureTooltipVisible);
  }

  void _concealTooltip() {
    if (_isConcealed || _forceRemoval) {
      // Already concealed, or it's being removed.
      return;
    }
    _isConcealed = true;
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    if (_entry != null) {
      _entry.remove();
    }
    _controller.reverse();
  }

  void _revealTooltip() {
    if (!_isConcealed) {
      // Already uncovered.
      return;
    }
    _isConcealed = false;
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    if (!_entry.mounted) {
      final OverlayState overlayState = Overlay.of(
        context,
        debugRequiredFor: widget,
      );
      overlayState.insert(_entry);
    }
    SemanticsService.tooltip(_tooltipMessage);
    _controller.forward();
  }

  bool ensureTooltipVisible() {
    if (!_visible || !mounted) {
      return false;
    }
    _showTimer?.cancel();
    _showTimer = null;
    _forceRemoval = false;
    if (_isConcealed) {
      if (_mouseIsConnected) {
        ToolTipButtonWidget._concealOtherTooltips(this);
      }
      _revealTooltip();
      return true;
    }
    if (_entry != null) {
      // Stop trying to hide, if we were.
      _dismissTimer?.cancel();
      _dismissTimer = null;
      _controller.forward();
      return false; // Already visible.
    }
    _createNewEntry();
    _controller.forward();
    return true;
  }

  static final Set<TooltipState> _mouseIn = <TooltipState>{};

  void _handleMouseEnter() {
    if (mounted) {
      _showTooltip();
    }
  }

  void _handleMouseExit({bool immediately = false}) {
    if (mounted) {
      _dismissTooltip(immediately: _isConcealed || immediately);
    }
  }

  void _createNewEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    );

    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset target = box.localToGlobal(
      box.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );
    final Widget overlay = Directionality(
      textDirection: Directionality.of(context),
      child: _TooltipOverlay(
        richMessage: widget.message,
        imageUrl: widget.imageUrl,
        buttonName: widget.buttonName,
        height: _height,
        padding: _padding,
        margin: _margin,
        onEnter: _mouseIsConnected ? (_) => _handleMouseEnter() : null,
        onExit: _mouseIsConnected ? (_) => _handleMouseExit() : null,
        decoration: _decoration,
        textStyle: _textStyle,
        textAlign: _textAlign,
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        target: target,
        verticalOffset: _verticalOffset,
        preferBelow: _preferBelow,
      ),
    );
    _entry = OverlayEntry(builder: (BuildContext context) => overlay);
    _isConcealed = false;
    overlayState.insert(_entry);
    SemanticsService.tooltip(_tooltipMessage);
    if (_mouseIsConnected) {
      ToolTipButtonWidget._concealOtherTooltips(this);
    }
    assert(!ToolTipButtonWidget._openedTooltips.contains(this));
    ToolTipButtonWidget._openedTooltips.add(this);
  }

  void _removeEntry() {
    ToolTipButtonWidget._openedTooltips.remove(this);
    _mouseIn.remove(this);
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    if (!_isConcealed) {
      _entry?.remove();
    }
    _isConcealed = false;
    _entry = null;
    if (_mouseIsConnected) {
      ToolTipButtonWidget._revealLastTooltip();
    }
  }

  void _handlePointerEvent(PointerEvent event) {
    if (_entry == null) {
      return;
    }
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _handleMouseExit();
    } else if (event is PointerDownEvent) {
      _handleMouseExit(immediately: true);
    }
  }

  @override
  void deactivate() {
    if (_entry != null) {
      _dismissTooltip(immediately: true);
    }
    _showTimer?.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter
        .removeGlobalRoute(_handlePointerEvent);
    RendererBinding.instance.mouseTracker
        .removeListener(_handleMouseTrackerChange);
    _removeEntry();
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    _pressActivated = true;
    final bool tooltipCreated = ensureTooltipVisible();
    if (tooltipCreated && _enableFeedback) {
      if (_triggerMode == TooltipTriggerMode.longPress) {
        Feedback.forLongPress(context);
      } else {
        Feedback.forTap(context);
      }
    }
    widget.onTriggered?.call();
  }

  void _handleTap() {
    _handlePress();
    _handleMouseExit();
  }

  @override
  Widget build(BuildContext context) {
    print('imageUrl: $widget.imageUrl');
    if (_tooltipMessage.isEmpty) {
      return widget.child ?? const SizedBox();
    }
    assert(Overlay.of(context, debugRequiredFor: widget) != null);
    final ThemeData theme = Theme.of(context);
    final TooltipThemeData tooltipTheme = TooltipTheme.of(context);
    TextStyle defaultTextStyle;
    BoxDecoration defaultDecoration;
    if (theme.brightness == Brightness.dark) {
      defaultTextStyle = theme.textTheme.bodyText2.copyWith(
        color: Colors.black,
        fontSize: _getDefaultFontSize(),
      );
      defaultDecoration = BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      );
    } else {
      defaultTextStyle = theme.textTheme.bodyText2.copyWith(
        color: Colors.white,
        fontSize: _getDefaultFontSize(),
      );
      defaultDecoration = BoxDecoration(
        color: Colors.grey[700].withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      );
    }

    _height =
        widget.height ?? tooltipTheme.height ?? _getDefaultTooltipHeight();
    _padding = widget.padding ?? tooltipTheme.padding ?? _getDefaultPadding();
    _margin = widget.margin ?? tooltipTheme.margin ?? _defaultMargin;
    _verticalOffset = widget.verticalOffset ??
        tooltipTheme.verticalOffset ??
        _defaultVerticalOffset;
    _preferBelow =
        widget.preferBelow ?? tooltipTheme.preferBelow ?? _defaultPreferBelow;
    _excludeFromSemantics = widget.excludeFromSemantics ??
        tooltipTheme.excludeFromSemantics ??
        _defaultExcludeFromSemantics;
    _decoration =
        widget.decoration ?? tooltipTheme.decoration ?? defaultDecoration;
    _textStyle = widget.textStyle ?? tooltipTheme.textStyle ?? defaultTextStyle;
    _textAlign =
        widget.textAlign ?? tooltipTheme.textAlign ?? _defaultTextAlign;
    _waitDuration = widget.waitDuration ??
        tooltipTheme.waitDuration ??
        _defaultWaitDuration;
    _showDuration = widget.showDuration ??
        tooltipTheme.showDuration ??
        _defaultShowDuration;
    _hoverShowDuration = widget.showDuration ??
        tooltipTheme.showDuration ??
        _defaultHoverShowDuration;
    _triggerMode =
        widget.triggerMode ?? tooltipTheme.triggerMode ?? _defaultTriggerMode;
    _enableFeedback = widget.enableFeedback ??
        tooltipTheme.enableFeedback ??
        _defaultEnableFeedback;

    Widget result = Semantics(
      tooltip: _excludeFromSemantics ? null : _tooltipMessage,
      child: ButtonWidget(title: widget.buttonName, onPressed: () {}),
    );

    // Only check for gestures if tooltip should be visible.
    if (_visible) {
      result = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: (_triggerMode == TooltipTriggerMode.longPress)
            ? _handlePress
            : null,
        onTap: (_triggerMode == TooltipTriggerMode.tap) ? _handleTap : null,
        excludeFromSemantics: true,
        child: result,
      );
      // Only check for hovering if there is a mouse connected.
      if (_mouseIsConnected) {
        result = MouseRegion(
          onEnter: (_) => _handleMouseEnter(),
          onExit: (_) => _handleMouseExit(),
          child: result,
        );
      }
    }

    return result;
  }
}

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  _TooltipPositionDelegate({
    @required this.target,
    @required this.verticalOffset,
    @required this.preferBelow,
  })  : assert(target != null),
        assert(verticalOffset != null),
        assert(preferBelow != null);

  final Offset target;
  final double verticalOffset;
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    @required this.height,
    @required this.richMessage,
    @required this.imageUrl,
    @required this.buttonName,
    this.padding,
    this.margin,
    this.decoration,
    this.textStyle,
    this.textAlign,
    @required this.animation,
    @required this.target,
    @required this.verticalOffset,
    @required this.preferBelow,
    this.onEnter,
    this.onExit,
  });

  final String richMessage;
  final String imageUrl;
  final String buttonName;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Decoration decoration;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Animation<double> animation;
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;
  final PointerEnterEventListener onEnter;
  final PointerExitEventListener onExit;

  @override
  Widget build(BuildContext context) {
    Widget result = IgnorePointer(
        child: FadeTransition(
      opacity: animation,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2,
          child: Container(
            decoration: decoration,
            padding: padding,
            margin: margin,
            child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Column(
                  children: [Text(richMessage), imageUrl==null?SizedBox(height: 1):Image.network(imageUrl)],
                )
                // Text.rich(
                //   richMessage,
                //   style: textStyle,
                //   textAlign: textAlign,
                // ),
                ),
          ),
        ),
      ),
    ));
    if (onEnter != null || onExit != null) {
      result = MouseRegion(
        onEnter: onEnter,
        onExit: onExit,
        child: result,
      );
    }
    return Positioned.fill(
      bottom: MediaQuery.maybeOf(context)?.viewInsets.bottom ?? 0.0,
      child: CustomSingleChildLayout(
        delegate: _TooltipPositionDelegate(
          target: target,
          verticalOffset: verticalOffset,
          preferBelow: preferBelow,
        ),
        child: result,
      ),
    );
  }
}
