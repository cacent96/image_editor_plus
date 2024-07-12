import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  const CustomColorPicker({
    Key? key,
    required this.initialColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
  }

  void pickAdvancedColor(BuildContext context, Color currentColor, ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.color_lens, color: Colors.white),
              onPressed: () {
                pickAdvancedColor(context, _currentColor, (color) {
                  setState(() {
                    _currentColor = color;
                    widget.onColorSelected(_currentColor);
                  });
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: predefinedColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentColor = color;
                          widget.onColorSelected(_currentColor);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _currentColor == color ? Colors.white : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final List<Color> predefinedColors = [
  Colors.black,
  Colors.grey,
  Colors.white,
  Colors.amber,
  Colors.amberAccent,
  Colors.blue,
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.brown,
  Colors.cyan,
  Colors.cyanAccent,
  Colors.deepOrange,
  Colors.deepOrangeAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.green,
  Colors.greenAccent,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.lime,
  Colors.limeAccent,
  Colors.orange,
  Colors.orangeAccent,
  Colors.pink,
  Colors.pinkAccent,
  Colors.purple,
  Colors.purpleAccent,
  Colors.red,
  Colors.redAccent,
  Colors.teal,
  Colors.tealAccent,
  Colors.yellow,
  Colors.yellowAccent,
  Colors.brown,
  Colors.grey,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.orange,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.blueGrey,
  Colors.lime,
  Colors.pink,
  Colors.teal,
];

