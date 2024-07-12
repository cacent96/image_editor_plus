import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class LinkEditorImage extends StatefulWidget {
  const LinkEditorImage({super.key});

  @override
  createState() => _LinkEditorImageState();
}

class _LinkEditorImageState extends State<LinkEditorImage> {
  TextEditingController name = TextEditingController();
  Color currentColor = Colors.white;
  Color backgroundColor = Colors.transparent;
  double slider = 32.0;
  TextAlign align = TextAlign.left;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 10.0,
        right: 10.0,
        top: 20.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.alignLeft,
                      color: align == TextAlign.left
                          ? Colors.white
                          : Colors.white.withAlpha(80)),
                  onPressed: () {
                    setState(() {
                      align = TextAlign.left;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.alignCenter,
                      color: align == TextAlign.center
                          ? Colors.white
                          : Colors.white.withAlpha(80)),
                  onPressed: () {
                    setState(() {
                      align = TextAlign.center;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.alignRight,
                      color: align == TextAlign.right
                          ? Colors.white
                          : Colors.white.withAlpha(80)),
                  onPressed: () {
                    setState(() {
                      align = TextAlign.right;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      LinkLayerData(
                        background: Colors.transparent,
                        text: name.text,
                        color: currentColor,
                        size: slider.toDouble(),
                        align: align,
                      ),
                    );
                  },
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Please insert your link(www.sharemo.com.my)',
                      hintStyle: const TextStyle(color: Colors.white70),
                    ),
                    scrollPadding: const EdgeInsets.all(20.0),
                    keyboardType: TextInputType.url,
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(
                      color: currentColor,
                    ),
                    autofocus: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
