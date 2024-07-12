import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'custom_color_picker.dart'; // Import the custom color picker

class LinkLayerOverlay extends StatefulWidget {
  final int index;
  final LinkLayerData layer;
  final Function onUpdate;

  const LinkLayerOverlay({
    super.key,
    required this.layer,
    required this.index,
    required this.onUpdate,
  });

  @override
  createState() => _LinkLayerOverlayState();
}

class _LinkLayerOverlayState extends State<LinkLayerOverlay> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double slider = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 318,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // Custom tab
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55, // 55% of screen width
                child: TabBar(
                  controller: _tabController,
                  indicator: const BoxDecoration(), // Remove underline
                  tabs: [
                    Tab(
                      child: Text(
                        'Color',
                        style: TextStyle(
                          color: _tabController.index == 0 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Background',
                        style: TextStyle(
                          color: _tabController.index == 1 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                  onTap: (index) {
                    setState(() {}); // Refresh to update text color
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Content Color Tab
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomColorPicker(
                        initialColor: Colors.black,
                        onColorSelected: (color) {
                          setState(() {
                            widget.layer.color = color;
                            widget.onUpdate();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Background Color Tab
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomColorPicker(
                        initialColor: Colors.white,
                        onColorSelected: (color) {
                          setState(() {
                            widget.layer.background = color;
                            if (widget.layer.backgroundOpacity == 0) {
                              widget.layer.backgroundOpacity = 0.5;
                            }
                            widget.onUpdate();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Always visible size and opacity sliders
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(color: Colors.white),
                          ),
                          Slider(
                            thumbColor: Colors.green,
                            activeColor: Colors.green,
                            value: widget.layer.size,
                            min: 0.0,
                            max: 100.0,
                            onChangeEnd: (v) {
                              setState(() {
                                widget.layer.size = v.toDouble();
                                widget.onUpdate();
                              });
                            },
                            onChanged: (v) {
                              setState(() {
                                slider = v;
                                widget.layer.size = v.toDouble();
                                widget.onUpdate();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.layer.size = 0.0;
                          widget.onUpdate();
                        });
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Background Opacity',
                            style: TextStyle(color: Colors.white),
                          ),
                          Slider(
                            thumbColor: Colors.green,
                            activeColor: Colors.green,
                            min: 0,
                            max: 1,
                            divisions: 100,
                            value: widget.layer.backgroundOpacity,
                            onChanged: (double value) {
                              setState(() {
                                widget.layer.backgroundOpacity = value;
                                widget.onUpdate();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.layer.backgroundOpacity = 0.5;
                          widget.onUpdate();
                        });
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
