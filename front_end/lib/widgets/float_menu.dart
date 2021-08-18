import 'package:flutter/material.dart';

enum PanelShape { rectangle, rounded }

class FloatBoxPanel extends StatefulWidget {
  final Color borderColor;
  final double borderWidth;
  final double size;
  final int iconSize;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color contentColor;
  final PanelShape panelShape;
  final Axis panelDirect;
  final List<IconData> buttons;
  final Function(int) onPressed;

  FloatBoxPanel(
      {this.buttons,
      this.borderColor,
      this.borderWidth,
      this.size,
      this.iconSize,
      this.borderRadius,
      @required this.panelDirect,
      this.backgroundColor,
      this.contentColor,
      this.panelShape,
      @required this.onPressed});

  @override
  _FloatBoxState createState() => _FloatBoxState();
}

class _FloatBoxState extends State<FloatBoxPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // All Buttons;
    List<IconData> _buttons = widget.buttons;

    // Widget size if the width of the panel;
    double _widgetSize = widget.size ?? 70.0;

    // If panel shape is set to rectangle, the border radius will be set to custom
    // border radius property of the WIDGET, else it will be set to the size of
    // widget to make all corners rounded.
    BorderRadius _borderRadius() {
      if (widget.panelShape != null &&
          widget.panelShape == PanelShape.rectangle) {
        // If panel shape is 'rectangle', border radius can be set to custom or 0;
        return widget.borderRadius ?? BorderRadius.circular(0);
      } else {
        // If panel shape is 'rounded', border radius will be the size of widget
        // to make it rounded;
        return BorderRadius.circular(_widgetSize);
      }
    }

    // Panel border is only enabled if the border width is greater than 0;
    Border _panelBorder() {
      if (widget.borderWidth != null && widget.borderWidth > 0) {
        return Border.all(
          color: widget.borderColor ?? Color(0xFF333333),
          width: widget.borderWidth ?? 0.0,
        );
      } else {
        return null;
      }
    }

    // Animated positioned widget can be moved to any part of the screen with
    // animation;
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Color(0xFF333333),
        borderRadius: _borderRadius(),
        border: _panelBorder(),
      ),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Visibility(
            visible: true,
            child: Container(
              child: Flex(
                direction: widget.panelDirect,
                children: List.generate(_buttons.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onPressed(index);
                    },
                    child: _FloatButton(
                      size: widget.size ?? 70.0,
                      icon: _buttons[index] ?? Icons.add,
                      color: widget.contentColor ?? Colors.white,
                      iconSize: widget.iconSize ?? 24.0,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatButton extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  final double iconSize;

  _FloatButton({this.size, this.color, this.icon, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.0),
      width: size ?? 70.0,
      height: size ?? 70.0,
      child: Icon(
        icon ?? Icons.add,
        color: color ?? Colors.white,
        size: iconSize ?? 24.0,
      ),
    );
  }
}
