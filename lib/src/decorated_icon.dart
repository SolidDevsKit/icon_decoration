import 'package:flutter/material.dart';
import 'package:icon_decoration/src/icon_decoration.dart';

/// Reimplementation of the [Icon] widget which adds support for shadows and
/// borders trough its [decoration] property.
class DecoratedIcon extends StatelessWidget {
  final Icon child;
  final IconDecoration? decoration;

  const DecoratedIcon({
    Key? key,
    required this.child,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = child.icon!;
    final textDirection = child.textDirection ?? Directionality.of(context);
    final iconTheme = IconTheme.of(context);
    final iconSize = child.size ?? iconTheme.size ?? 24.0;
    final iconOpacity = iconTheme.opacity ?? 1.0;
    final border = decoration?.border;
    Color iconColor = child.color ?? iconTheme.color!;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    final iconStyle = TextStyle(
      inherit: false,
      color: iconColor,
      fontSize: iconSize,
      fontFamily: icon.fontFamily,
      package: icon.fontPackage,
      shadows: decoration?.shadows,
    );

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible,
      textDirection: textDirection,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: iconStyle,
      ),
    );

    if (icon.matchTextDirection) {
      switch (textDirection) {
        case TextDirection.rtl:
          iconWidget = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconWidget,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    if (border != null) {
      // Remove shadows from the widget as it will be displayed by the border.
      iconWidget = RichText(
        overflow: TextOverflow.visible,
        textDirection: textDirection,
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: iconStyle.copyWith(shadows: null),
        ),
      );
      iconWidget = Stack(
        alignment: Alignment.center,
        textDirection: textDirection,
        children: [
          RichText(
            overflow: TextOverflow.visible,
            textDirection: textDirection,
            textAlign: TextAlign.center,
            text: TextSpan(
              text: String.fromCharCode(icon.codePoint),
              style: iconStyle.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeCap = StrokeCap.round
                  ..strokeJoin = StrokeJoin.round
                  ..strokeWidth = border.width
                  ..color = border.color,
                color: null,
              ),
            ),
          ),
          iconWidget,
        ],
      );
    }

    return Semantics(
      label: child.semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Center(child: iconWidget),
        ),
      ),
    );
  }
}
