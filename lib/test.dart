// import 'package:flutter/material.dart';
//
// class TimePickerExample extends StatefulWidget {
//   @override
//   _TimePickerExampleState createState() => _TimePickerExampleState();
// }
//
// class _TimePickerExampleState extends State<TimePickerExample> {
//   TimeOfDay? _selectedTime;
//
//   // Method to show the time picker
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );
//
//     if (pickedTime != null && pickedTime != _selectedTime) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Time Picker Example"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _selectedTime != null
//                   ? "Selected Time: ${_selectedTime!.format(context)}"
//                   : "No Time Selected",
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text("Select Time"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
///
import 'package:flutter/material.dart';

class TimePickerWithTextField extends StatefulWidget {
  @override
  _TimePickerWithTextFieldState createState() =>
      _TimePickerWithTextFieldState();
}

class _TimePickerWithTextFieldState extends State<TimePickerWithTextField> {
  TextEditingController _timeController = TextEditingController();

  // Method to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Format and set the selected time in the TextField
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Picker with TextField"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _timeController,
              readOnly: true, // Prevent manual input
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                labelText: "Selected Time",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text("Select Time"),
            ),
          ],
        ),
      ),
    );
  }
}

