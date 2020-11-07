import 'package:flutter/material.dart';

class DragBox extends StatefulWidget {
  final Color itemColor;

  DragBox(this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: widget.itemColor,
                borderRadius: BorderRadius.circular(20)),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            width: 50.0,
            height: 50.0,
            color: widget.itemColor.withOpacity(0.5),
          ),
        ));
  }
}
