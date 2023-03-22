import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen(
      {super.key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem})
      : isUpdating = (originalItem != null);
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;
  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(groceryItem);
              } else {
                widget.onCreate(groceryItem);
              }
              context.goNamed(
                'home',
                params: {'tab': '${FooderlichTab.toBuy}'},
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
        elevation: 0,
        title: Text(
          "Grocery Item",
          style: GoogleFonts.openSans(
            textStyle: GoogleFonts.lato(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            buildImportantField(),
            buildDateField(context),
            buildTimeField(context),
            buildColorPicker(context),
            buildQuantityField(),
            GroceryTile(
              item: GroceryItem(
                id: 'previewMode',
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(
        hour: date.hour,
        minute: date.minute,
      );
      _dueDate = date;
    }
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Item Name",
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: "E.g. Apples, Bread, Eggs, etc.",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportantField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Importance", style: GoogleFonts.lato(fontSize: 28.0)),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
                selectionColor: Colors.black,
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
              selected: _importance == Importance.low,
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
                selectionColor: Colors.black,
              ),
              selected: _importance == Importance.medium,
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
                selectionColor: Colors.black,
              ),
              selected: _importance == Importance.high,
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
              child: const Text("Select"),
            ),
          ],
        ),
        Text(
          DateFormat('yyyy-MM-dd').format(_dueDate),
        ),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Time",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: _timeOfDay,
                );
                setState(() {
                  if (selectedTime != null) {
                    _timeOfDay = selectedTime;
                  }
                });
              },
              child: const Text("Select"),
            ),
          ],
        ),
        Text(
          _timeOfDay.format(context),
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Color",
              style: GoogleFonts.lato(fontSize: 28),
            ),
          ],
        ),
        TextButton(
          onPressed: () async {
            showDialog<Color>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Select a color"),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: _currentColor,
                    onColorChanged: (color) {
                      setState(() {
                        _currentColor = color;
                      });
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          },
          child: const Text("Select"),
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Quantity",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ],
        ),
        Slider(
          value: _currentSliderValue.toDouble(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          min: 0,
          max: 100,
          divisions: 100,
          label: _currentSliderValue.toInt().toString(),
        ),
      ],
    );
  }
}
