import 'dart:io';

import 'package:flutter/material.dart';

File arch;

class StoryEditor extends StatefulWidget {
  final File archImagen;

  StoryEditor(this.archImagen);

  @override
  _StoryEditorState createState() => _StoryEditorState();
}

class _StoryEditorState extends State<StoryEditor> {
  EditableItem _activeItem;

  Offset _initPos;

  Offset _currentPos;

  double _currentScale;

  double _currentRotation;

  bool _inAction = false;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onScaleStart: (details) {
          if (_activeItem == null) return;

          _initPos = details.focalPoint;
          _currentPos = _activeItem.position;
          _currentScale = _activeItem.scale;
          _currentRotation = _activeItem.rotation;
        },
        onScaleUpdate: (details) {
          if (_activeItem == null) return;
          final delta = details.focalPoint - _initPos;
          final left = (delta.dx / screen.width) + _currentPos.dx;
          final top = (delta.dy / screen.height) + _currentPos.dy;

          setState(() {
            _activeItem.position = Offset(left, top);
            _activeItem.rotation = details.rotation + _currentRotation;
            _activeItem.scale = details.scale * _currentScale;
          });
        },
        child: Stack(
          children: [
            Container(color: Colors.black26),

            //...mockData.map(_buildItemWidget).toList()
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(EditableItem e) {
    final screen = MediaQuery.of(context).size;

    //var widget;
    /*switch (e.type) {
      case ItemType.Text:
        widget = Text(
          e.value,
          style: TextStyle(color: Colors.white),
        );
        break;
      case ItemType.File:
        e.value = widget.archImagen;
        widget = File(e.value);
    }*/

    return Positioned(
      top: e.position.dy * screen.height,
      left: e.position.dx * screen.width,
      child: Transform.scale(
        scale: e.scale,
        child: Transform.rotate(
          angle: e.rotation,
          child: Listener(
            onPointerDown: (details) {
              if (_inAction) return;
              _inAction = true;
              _activeItem = e;
              _initPos = details.position;
              _currentPos = e.position;
              _currentScale = e.scale;
              _currentRotation = e.rotation;
            },
            onPointerUp: (details) {
              _inAction = false;
            },
            child: widget,
          ),
        ),
      ),
    );
  }
}

class EditableItem {
  Offset position = Offset(0.1, 0.1);
  double scale = 1.0;
  double rotation = 0.0;
  //ItemType type;
  var value;
}
/*enum ItemType { File, Text }



final mockData = [
  EditableItem()..type = ItemType.File,
  EditableItem()
    ..type = ItemType.Text
    ..value = 'Hola',
  EditableItem()
    ..type = ItemType.Text
    ..value = 'Mundo',
];*/
