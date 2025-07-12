// // import 'package:flutter/material.dart';
// //
// // class TimePickerExample extends StatefulWidget {
// //   @override
// //   _TimePickerExampleState createState() => _TimePickerExampleState();
// // }
// //
// // class _TimePickerExampleState extends State<TimePickerExample> {
// //   TimeOfDay? _selectedTime;
// //
// //   // Method to show the time picker
// //   Future<void> _selectTime(BuildContext context) async {
// //     final TimeOfDay? pickedTime = await showTimePicker(
// //       context: context,
// //       initialTime: _selectedTime ?? TimeOfDay.now(),
// //     );
// //
// //     if (pickedTime != null && pickedTime != _selectedTime) {
// //       setState(() {
// //         _selectedTime = pickedTime;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Time Picker Example"),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               _selectedTime != null
// //                   ? "Selected Time: ${_selectedTime!.format(context)}"
// //                   : "No Time Selected",
// //               style: TextStyle(fontSize: 18),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () => _selectTime(context),
// //               child: Text("Select Time"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// ///
// import 'package:flutter/material.dart';
//
// class TimePickerWithTextField extends StatefulWidget {
//   @override
//   _TimePickerWithTextFieldState createState() =>
//       _TimePickerWithTextFieldState();
// }
//
// class _TimePickerWithTextFieldState extends State<TimePickerWithTextField> {
//   TextEditingController _timeController = TextEditingController();
//
//   // Method to show the time picker
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       setState(() {
//         // Format and set the selected time in the TextField
//         _timeController.text = pickedTime.format(context);
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _timeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Time Picker with TextField"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _timeController,
//               readOnly: true, // Prevent manual input
//               onTap: () => _selectTime(context),
//               decoration: InputDecoration(
//                 labelText: "Selected Time",
//                 border: OutlineInputBorder(),
//               ),
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
// import 'package:doctor_apk/res/color_constant.dart';
// import 'package:flutter/material.dart';
//
// class PrescriptionPage extends StatelessWidget {
//   const PrescriptionPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Prescription'),
//         backgroundColor: Colors.blue.shade800,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Doctor Information
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Dr. Aman Chauhan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text('MBBS, MD - Cardiology'),
//                         Text('Reg. No: DMC-12345'),
//                       ],
//                     ),
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: AssetImage('assets/doctor.jpg'),
//                     )
//                   ],
//                 ),
//                 const Divider(height: 30, thickness: 1),
//
//                 /// Patient Info
//                 const Text('Patient Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text('Name: John Doe'),
//                     Text('Age: 28'),
//                     Text('Gender: Male'),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 const Text('Date: 11 July 2025'),
//
//                 const Divider(height: 30, thickness: 1),
//
//                 /// Symptoms
//                 const Text('Symptoms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 8),
//                 const Text('- Headache\n- Fatigue\n- Mild Fever'),
//
//                 const Divider(height: 30, thickness: 1),
//
//                 /// Prescription
//                 const Text('Prescription', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 8),
//                 const Text(
//                   '1. Paracetamol 500mg – 1 tablet twice a day after meal\n'
//                       '2. ORS – 1 packet in 1L water\n'
//                       '3. Rest for 2 days\n',
//                 ),
//
//                 const Divider(height: 30, thickness: 1),
//
//                 /// Notes
//                 const Text('Doctor\'s Notes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Patient advised to hydrate well and take rest.\n'
//                       'Follow-up in 3 days if symptoms persist.',
//                 ),
//
//                 const Spacer(),
//
//                 /// Signature
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: const [
//                       Text('Signature', style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 40),
//                       Text('Dr. Aman Chauhan'),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// class StylishPrescriptionFormPage extends StatefulWidget {
//   const StylishPrescriptionFormPage({super.key});
//
//   @override
//   State<StylishPrescriptionFormPage> createState() => _StylishPrescriptionFormPageState();
// }
//
// class _StylishPrescriptionFormPageState extends State<StylishPrescriptionFormPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _symptomsController = TextEditingController();
//   final TextEditingController _medicinesController = TextEditingController();
//   final TextEditingController _notesController = TextEditingController();
//
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // Add submission logic here
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Prescription Saved")),
//       );
//     }
//   }
//
//   Widget _buildCard({required IconData icon, required String title, required Widget child}) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color:   ColorConstant.lightGrayColor,),
//               const SizedBox(width: 10),
//               Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           child,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({required String hint, required TextEditingController controller, int maxLines = 1, TextInputType type = TextInputType.text}) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       keyboardType: type,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: ColorConstant.lightGrayColor.withAlpha(100))),
//         focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: ColorConstant.lightGrayColor)),
//       ),
//       validator: (value) => value == null || value.isEmpty ? 'Required' : null,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.blue.shade50,
//       appBar: AppBar(
//         title: const Text('🩺 Prescription Form',style: TextStyle(color: Colors.white),),
//         backgroundColor: ColorConstant.lightGrayColor,
//         elevation: 4,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               _buildCard(
//                 icon: Icons.person,
//                 title: 'Patient Info',
//                 child: Column(
//                   children: [
//                     _buildTextField(hint: 'Patient Name', controller: _nameController),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Expanded(child: _buildTextField(hint: 'Age', controller: _ageController, type: TextInputType.number)),
//                         const SizedBox(width: 12),
//                         Expanded(child: _buildTextField(hint: 'Gender', controller: _genderController)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               _buildCard(
//                 icon: Icons.sick,
//                 title: 'Symptoms',
//                 child: _buildTextField(hint: 'e.g. Fever, cough, fatigue...', controller: _symptomsController, maxLines: 3),
//               ),
//               _buildCard(
//                 icon: Icons.medication,
//                 title: 'Medicines',
//                 child: _buildTextField(hint: 'e.g. Paracetamol 500mg...', controller: _medicinesController, maxLines: 4),
//               ),
//               _buildCard(
//                 icon: Icons.note_alt,
//                 title: 'Doctor\'s Notes',
//                 child: _buildTextField(hint: 'Any additional advice...', controller: _notesController, maxLines: 3),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: _submit,
//                 icon: const Icon(Icons.send,color: Colors.white),
//                 label: const Text("Submit Prescription", style: TextStyle(fontSize: 16,color: Colors.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:   ColorConstant.lightGrayColor,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// class PrescriptionFormPage extends StatefulWidget {
//   const PrescriptionFormPage({super.key});
//
//   @override
//   State<PrescriptionFormPage> createState() => _PrescriptionFormPageState();
// }
//
// class _PrescriptionFormPageState extends State<PrescriptionFormPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _patientNameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _symptomsController = TextEditingController();
//   final TextEditingController _medicineController = TextEditingController();
//   final TextEditingController _notesController = TextEditingController();
//
//   @override
//   void dispose() {
//     _patientNameController.dispose();
//     _ageController.dispose();
//     _genderController.dispose();
//     _symptomsController.dispose();
//     _medicineController.dispose();
//     _notesController.dispose();
//     super.dispose();
//   }
//
//   void _submitPrescription() {
//     if (_formKey.currentState!.validate()) {
//       // Here you can push data to Firebase or any database
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Prescription submitted successfully")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text("Create Prescription",style: TextStyle(color: Colors.white,fontSize: 18),),
//         backgroundColor: ColorConstant.lightGrayColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               /// Patient Name
//               TextFormField(
//                 controller: _patientNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Patient Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) => value!.isEmpty ? 'Required field' : null,
//               ),
//               const SizedBox(height: 16),
//
//               /// Age & Gender
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _ageController,
//                       decoration: const InputDecoration(
//                         labelText: 'Age',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) => value!.isEmpty ? 'Required' : null,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _genderController,
//                       decoration: const InputDecoration(
//                         labelText: 'Gender',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) => value!.isEmpty ? 'Required' : null,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//
//               /// Symptoms
//               TextFormField(
//                 controller: _symptomsController,
//                 decoration: const InputDecoration(
//                   labelText: 'Symptoms',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//                 validator: (value) => value!.isEmpty ? 'Required field' : null,
//               ),
//               const SizedBox(height: 16),
//
//               /// Medicines
//               TextFormField(
//                 controller: _medicineController,
//                 decoration: const InputDecoration(
//                   labelText: 'Prescribed Medicines',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 4,
//                 validator: (value) => value!.isEmpty ? 'Required field' : null,
//               ),
//               const SizedBox(height: 16),
//
//               /// Doctor Notes
//               TextFormField(
//                 controller: _notesController,
//                 decoration: const InputDecoration(
//                   labelText: 'Doctor Notes',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 24),
//
//               /// Submit Button
//               ElevatedButton.icon(
//                 onPressed: _submitPrescription,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorConstant.lightGrayColor,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 icon: const Icon(Icons.check_circle,color: Colors.white,),
//                 label: const Text("Submit Prescription", style: TextStyle(fontSize: 16,color: Colors.white)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
