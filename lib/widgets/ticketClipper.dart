import 'package:flutter/material.dart';
import 'package:love_on_life/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.shadow,
    this.notchRadius = 20.0,
    this.dyOffset = 0.0,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;

  final double notchRadius;
  final double dyOffset;

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Stack(
        children: [
          // Shadow + background
          PhysicalShape(
            clipper: TicketClipper(
              radius: widget.isCornerRounded ? 8.0 : 0.0,
              notchWidth: widget.notchRadius,
              notchHeight: widget.notchRadius * 1.5,
              dyOffset: widget.dyOffset,
            ),
            color: widget.color,
            elevation: widget.shadow != null ? 5 : 0,
            shadowColor: widget.shadow != null ? Colors.black.withOpacity(0.2) : Colors.transparent,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
            ),
          ),

          // Border using textfieldBorderColor
          CustomPaint(
            size: Size(widget.width, widget.height),
            painter: TicketBorderPainter(
              radius: widget.isCornerRounded ? 8.0 : 0.0,
              notchWidth: widget.notchRadius,
              notchHeight: widget.notchRadius * 1.5,
              dyOffset: widget.dyOffset,
              color: textfieldBorderColor, // ✅ use your textfieldBorderColor
              strokeWidth: 0.2.w,           // slightly bigger for visibility
            ),
          ),

          // Content
          Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double radius;
  final double notchWidth;
  final double notchHeight;
  final double dyOffset;

  TicketClipper({
    this.radius = 0.0,
    this.notchWidth = 20.0,
    this.notchHeight = 40.0,
    this.dyOffset = 0.0,
  });

  @override
  Path getClip(Size size) {
    Path mainPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    Path notchPath = Path()
      ..addOval(Rect.fromLTWH(
        -notchWidth / 2,
        size.height / 2 - notchHeight / 2 + dyOffset,
        notchWidth,
        notchHeight,
      ))
      ..addOval(Rect.fromLTWH(
        size.width - notchWidth / 2,
        size.height / 2 - notchHeight / 2 + dyOffset,
        notchWidth,
        notchHeight,
      ));

    return Path.combine(PathOperation.difference, mainPath, notchPath);
  }

  @override
  bool shouldReclip(covariant TicketClipper oldClipper) {
    return oldClipper.notchWidth != notchWidth ||
        oldClipper.notchHeight != notchHeight ||
        oldClipper.radius != radius ||
        oldClipper.dyOffset != dyOffset;
  }
}

class TicketBorderPainter extends CustomPainter {
  final double radius;
  final double notchWidth;
  final double notchHeight;
  final double dyOffset;
  final Color color;
  final double strokeWidth;

  TicketBorderPainter({
    required this.radius,
    required this.notchWidth,
    required this.notchHeight,
    required this.dyOffset,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path mainPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    Path notchPath = Path()
      ..addOval(Rect.fromLTWH(
        -notchWidth / 2,
        size.height / 2 - notchHeight / 2 + dyOffset,
        notchWidth,
        notchHeight,
      ))
      ..addOval(Rect.fromLTWH(
        size.width - notchWidth / 2,
        size.height / 2 - notchHeight / 2 + dyOffset,
        notchWidth,
        notchHeight,
      ));

    Path finalPath = Path.combine(PathOperation.difference, mainPath, notchPath);

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant TicketBorderPainter oldDelegate) {
    return oldDelegate.notchWidth != notchWidth ||
        oldDelegate.notchHeight != notchHeight ||
        oldDelegate.radius != radius ||
        oldDelegate.dyOffset != dyOffset ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
