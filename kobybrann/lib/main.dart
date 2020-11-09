import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobybrann/widgets/colores.dart';
import 'dart:typed_data';
import 'package:kobybrann/utilidad.dart';
import 'package:kobybrann/widgets/message_widget.dart';
import 'package:kobybrann/widgets/widget_a_imagen.dart';
import 'package:kobybrann/widgets/editar_tamano.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:kobybrann/widgets/emoji_picker_widget.dart';
import 'package:kobybrann/widgets/input_widget.dart';

import 'widgets/emoji_picker_widget.dart';

/*
//aca va el stateful de emojis
class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final messages = <String>[];
  final controller = TextEditingController();
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibility.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });

      if (isKeyboardVisible && isEmojiVisible) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            children: <Widget>[
              /*Expanded(
                child: ListView(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  children: messages
                      .map((message) => MessageWidget(message: message))
                      .toList(),
                ),
              ),*/
              InputWidget(
                onBlurred: toggleEmojiKeyboard,
                controller: controller,
                isEmojiVisible: isEmojiVisible,
                isKeyboardVisible: isKeyboardVisible,
                onSentMessage: (message) =>
                    setState(() => messages.insert(0, message)),
              ),
              Offstage(
                child: EmojiPickerWidget(onEmojiSelected: onEmojiSelected),
                offstage: !isEmojiVisible,
              ),
            ],
          ),
        ),
      );

  void onEmojiSelected(String emoji) => setState(() {
        controller.text = controller.text + emoji;
      });

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }
}*/

void main() {
  runApp(new MaterialApp(
    title: "Camara APP",
    home: LandingScreen(),
  ));
}

class EditableItem {
  Offset position = Offset(0.1, 0.1);
  double scale = 1.0;
  double rotation = 0.0;
  File value;
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final messages = <String>[];
  final controller = TextEditingController();
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibility.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });

      if (isKeyboardVisible && isEmojiVisible) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
  }

  String te = "";
  File archivoImagen;
  File archivoImagen2;
  String emoji;
  DragBox colorFondoSet;
  Color caughtColor;

  GlobalKey key1;
  GlobalKey key2;
  GlobalKey key3;
  Uint8List bytes1;
  Uint8List bytes2;
  Uint8List bytes3;

  /*EditableItem _activeItem;
  Offset _initPos;
  Offset _currentPos;
  double _currentScale;
  double _currentRotation;
  bool _inAction = false;*/

  void onEmojiSelected(String emojiEscogido) => setState(() {
    /*controller.text = controller.text + emoji;
        print(controller.text);*/
    this.emoji = emojiEscogido;
    _escogerEmoji();
  });

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

//Aca da la opcion de escoger el color de fondo
  Future<void> _showChoiceDialogColor(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Elegir Color: "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      _azul(context);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.red,
                    ),
                    onTap: () {
                      _red(context);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.yellow,
                    ),
                    onTap: () {
                      _yellow(context);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.brown,
                    ),
                    onTap: () {
                      _brown(context);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.green,
                    ),
                    onTap: () {
                      _green(context);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      _orange(context);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.format_color_fill,
                      size: 25,
                      color: Colors.black,
                    ),
                    onTap: () {
                      _black(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();

//aca se declaran los colores
  _azul(BuildContext context) async {
    this.setState(() {
      caughtColor = Colors.blue;
    });
    Navigator.of(context).pop();
  }

  _red(BuildContext context) async {
    this.setState(() {
      caughtColor = Colors.red;
    });
    Navigator.of(context).pop();
  }

  _yellow(BuildContext context) async {
    DragBox(Colors.yellow);
    this.setState(() {
      caughtColor = Colors.yellow;
    });
    Navigator.of(context).pop();
  }

  _brown(BuildContext context) async {
    DragBox(Colors.brown);
    this.setState(() {
      caughtColor = Colors.brown;
    });
    Navigator.of(context).pop();
  }

  _green(BuildContext context) async {
    DragBox(Colors.green);
    this.setState(() {
      caughtColor = Colors.green;
    });
    Navigator.of(context).pop();
  }

  _orange(BuildContext context) async {
    DragBox(Colors.orange);
    this.setState(() {
      caughtColor = Colors.orange;
    });
    Navigator.of(context).pop();
  }

  _black(BuildContext context) async {
    DragBox(Colors.black);
    this.setState(() {
      caughtColor = Colors.black;
    });
    Navigator.of(context).pop();
  }

  _abrirGaleria2(BuildContext context) async {
    var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      archivoImagen2 = imagen;
    });
    // _activeItem.value = archivoImagen2;
    // _buildItemWidget(_activeItem);
    Navigator.of(context).pop();
  }

  _abrirGaleria(BuildContext context) async {
    var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      archivoImagen = imagen;
    });
    //  _activeItem.value = archivoImagen;
    // _buildItemWidget(_activeItem);
    Navigator.of(context).pop();
  }

  _abrirCamara(BuildContext context) async {
    var imagen = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      archivoImagen = imagen;
    });
    // _activeItem.value = archivoImagen;
    //_buildItemWidget(_activeItem);
    Navigator.of(context).pop();
  }

//movimiento de widgets
  /* Widget _buildItemWidget(EditableItem e) {
    final screen = MediaQuery.of(context).size;
    e.value = archivoImagen2;

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
  }*/

//aca se puede escoger la opcion de elegir la imagen de fonde ya sea de galeria o de la camara
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Elegir opción: "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _abrirGaleria(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      _abrirCamara(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Elegir opción: "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      _abrirGaleria2(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      _abrirCamara(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /* _mostrarTexto(BuildContext context) async {
    String texto = "";

    this.setState(() {
      te = texto;
    });
    Navigator.of(context).pop();
  }*/

  Future<void> _eltexto(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Ingrese el texto: "),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: TextField(
                        onChanged: (String str) {
                          this.setState(() {
                            te = str;
                          });
                        },
                      ),
                      onTap: () {
                        _textDPrueba();
                      },
                    ),
                    GestureDetector(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.lightBlue,
                        ),
                        color: Colors.white,
                        // padding: EdgeInsets.only(left: -10, right: -15),
                        /*shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color.fromARGB(30, 0, 0, 0)))*/
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Widget _textDPrueba() {
    if (Text(te) == null) {
      return Text("");
    } else {
      return Text(te);
    }
  }

  Widget _escogerImagen2() {
    if (archivoImagen2 == null) {
      return Text("");
    } else {
      return Center(
        child: Image.file(
          archivoImagen2,
          width: 350,
          height: 350,
        ),
      );
    }
  }

  Widget _escogerImagen() {
    //Emoji???
    if (archivoImagen == null &&
        caughtColor == null &&
        archivoImagen2 == null &&
        emoji != null) {
      return Text(emoji);
    } else if (archivoImagen == null &&
        caughtColor == null &&
        archivoImagen2 == null) {
      return Container(
          height: 350,
          width: 350,
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
              border: Border.all(color: Color.fromARGB(30, 0, 0, 0), width: 3)),
          child: Center(
              child: Text("No hay imagen o color de fondo seleccionado")));
    } else if (archivoImagen != null &&
        caughtColor == null &&
        archivoImagen2 == null) {
      return Image.file(
        archivoImagen,
        width: 350,
        height: 350,
      );
    } else if (archivoImagen == null &&
        caughtColor == null &&
        archivoImagen2 != null) {
      return Text("");
    } else if (archivoImagen != null &&
        caughtColor == null &&
        archivoImagen2 != null) {
      return Image.file(
        archivoImagen,
        width: 350,
        height: 350,
      );
    }
    else if (archivoImagen == null &&
        caughtColor != null &&
        archivoImagen2 == null) {
      return Positioned(
        left: 100.0,
        bottom: 50.0,
        child: DragTarget(
          onAccept: (Color color) {
            caughtColor = color;
          },
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Center(
              child: Column(
                children: [
                  Container(
                    width: 350.0,
                    height: 350.0,
                    decoration: BoxDecoration(
                      color:
                      accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text("Objeto a modificar"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
              border: Border.all(color: Color.fromARGB(30, 0, 0, 0), width: 3)),
          child: Center(
              child: Text("No hay imagen o color de fondo seleccionado")));
    }
  }

  Widget _escogerEmoji() {
    if (emoji == null) {
      return Text("No emoji escogido");
    } else {
      Navigator.of(context).pop();
      return showAlertDialog(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: new Text("Integrando"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Text("DISEÑAR LAYOUT"),
                  margin: EdgeInsets.only(top: 30),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        child: RaisedButton(
                            onPressed: () {
                              caughtColor = null;
                              _showChoiceDialog(context);
                            },
                            child: Text(
                              "JPG",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color.fromARGB(30, 0, 0, 0)))),
                        margin: EdgeInsets.only(top: 50, left: 30),
                        width: 55,
                      ),
                    ),
                    Center(
                      child: Container(
                        child: RaisedButton(
                          onPressed: () {
                            archivoImagen = null;
                            _showChoiceDialogColor(context);
                          },
                          child: Icon(
                            Icons.colorize,
                            color: Colors.white,
                          ),
                          color: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side:
                              BorderSide(color: Color.fromARGB(30, 0, 0, 0))),
                        ),
                        margin: EdgeInsets.only(top: 50, left: 30),
                        width: 50,
                      ),
                    ),
                    Center(
                      child: Container(
                        child: RaisedButton(
                            onPressed: () {
                              _showChoiceDialog2(context);
                            },
                            child: Text(
                              "PNG",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color.fromARGB(30, 0, 0, 0)))),
                        margin: EdgeInsets.only(top: 50, left: 30),
                        width: 55,
                      ),
                    ),
                    IconButton(icon: Icon(Icons.face), onPressed: (){
                      return showAlertDialog(context, false);
                    })
                    /*Center(
                      child: Container(
                        child: WillPopScope(
                          onWillPop: onBackPress,
                          child: Column(
                            children: <Widget>[
                              *//*Expanded(
                                child: ListView(
                                  reverse: true,
                                  physics: BouncingScrollPhysics(),
                                  children: messages
                                      .map((message) =>
                                          MessageWidget(message: message))
                                      .toList(),
                                ),
                              ),*//*
                              InputWidget(
                                onBlurred: toggleEmojiKeyboard,
                                controller: controller,
                                isEmojiVisible: isEmojiVisible,
                                isKeyboardVisible: isKeyboardVisible,
                                onSentMessage: (message) =>
                                    setState(() => messages.insert(0, message)),
                                //  setState(() => print(controller.text)),
                              ),
                              Offstage(
                                child: EmojiPickerWidget(
                                    onEmojiSelected: onEmojiSelected),
                                offstage: !isEmojiVisible,
                              ),
                            ],
                          ),
                        ),
                        margin: EdgeInsets.only(top: 50, left: 25),
                        //width: 50,
                      ),
                    ),*/

                    /* child: RaisedButton(
                            onPressed: () {
                              _eltexto(context);
                            },
                            child: Icon(
                              Icons.tag_faces,
                              color: Colors.white,
                            ),
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color.fromARGB(30, 0, 0, 0))))*/
                  ],
                ),
              ),
              Stack(children: [
                //aca van los widget que se convertiran, es un objeto por
                WidgetToImage(builder: (key) {
                  this.key1 = key;

                  return _escogerImagen();
                }),
                WidgetToImage(builder: (key) {
                  this.key2 = key;
                  return _escogerImagen2();
                }),
                WidgetToImage(builder: (key) {
                  this.key3 = key;
                  return _textDPrueba();
                }),
                buildImage(bytes1),
                buildImage(bytes2),
                buildImage(bytes3),
              ]),
              Center(
                child: Container(
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Color.fromARGB(30, 0, 0, 0))),
                    child: Text(
                      'Guardar Imagen',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      final bytes1 = await Utils.capture(key1);
                      final bytes2 = await Utils.capture(key2);
                      final bytes3 = await Utils.capture(key3);

                      setState(() {
                        this.bytes1 = bytes1;
                        this.bytes2 = bytes2;
                        this.bytes3 = bytes3;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Este popup recibe el contexto y otro argumento.
  ///El segundo argumento es para mostrar un emoji seleccionado o no
  ///Al llamarlo por primera vez se pasa falso
  ///Al seleccionar el emoji se pasa true y se esconde el primer popup
  showAlertDialog(BuildContext context, bool mostrarWidgetSeleccionado) {

    AlertDialog alert;

    if (mostrarWidgetSeleccionado){
      // Configura el popup
      alert = AlertDialog(
          title: Text("Emojis"),
          content: Text(emoji)
      );
    } else {
      // Configura el popup
      alert = AlertDialog(
          title: Text("Emojis"),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  //Usé la misma función que ya tenías
                  child: EmojiPickerWidget(
                    onEmojiSelected: onEmojiSelected,
                  ),
                ),
              ],
            ),
          )
      );
    }

    // Muestro el popup
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
