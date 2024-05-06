import 'package:flutter/material.dart';

class TextButtonWithIcon extends TextButton {
  TextButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _TextButtonWithIconChild(icon: icon, label: label),
        );
}

class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
    required this.label,
    required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).textScaler.scale(8);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[Flexible(child: label), SizedBox(width: scale), icon],
    );
  }
}
