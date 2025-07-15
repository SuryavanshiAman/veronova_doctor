
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/add_prescription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({super.key});

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  String appointmentId="";
  String slotId="";
  String phone="";
  String patientId="0";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _medicinesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
    Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _nameController.text = arguments["name"]??"";
    phone = arguments["phone"]??"";
    _ageController.text = arguments["age"]??"";
    _genderController.text = arguments["gender"]??"";

    });

  }
  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Add submission logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Prescription Saved")),
      );
    }
  }

  Widget _buildCard({required IconData icon, required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color:   ColorConstant.lightGrayColor,),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({required String hint, required TextEditingController controller, int maxLines = 1, TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorConstant.lightGrayColor.withAlpha(100))),
        focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorConstant.lightGrayColor)),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      patientId = arguments["patientId"].toString();
      appointmentId = arguments["appointmentId"].toString();
      slotId = arguments["slotId"].toString();
final addPrescription=Provider.of<AddPrescriptionViewModel>(context);
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('🩺 Prescription Form',style: TextStyle(color: Colors.white),),
        backgroundColor: ColorConstant.lightGrayColor,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildCard(
                icon: Icons.person,
                title: 'Patient Info',
                child: Column(
                  children: [
                    _buildTextField(hint: 'Patient Name', controller: _nameController),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(hint: 'Age', controller: _ageController, type: TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField(hint: 'Gender', controller: _genderController)),
                      ],
                    ),

                  ],
                ),
              ),
              _buildCard(
                icon: Icons.sick,
                title: 'Symptoms',
                child: _buildTextField(hint: 'Enter Symptoms', controller: _symptomsController, maxLines: 3),
              ),
              _buildCard(
                icon: Icons.medication,
                title: 'Medicines',
                child: _buildTextField(hint: 'Medicines', controller: _medicinesController, maxLines: 4),
              ),
              _buildCard(
                icon: Icons.note_alt,
                title: 'Doctor\'s Notes',
                child: _buildTextField(hint: 'Any additional advice...', controller: _notesController, maxLines: 3),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                // onPressed: _submit,
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    // Add submission logic here
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text("Prescription Saved")),
                    // );
                    addPrescription.addPrescriptionApi(patientId, _nameController.text, phone, "email", slotId, _ageController.text, _genderController.text, appointmentId, _symptomsController.text, _medicinesController.text, _notesController.text, context);
                  }
                },
                icon: const Icon(Icons.send,color: Colors.white),
                label: const Text("Submit Prescription", style: TextStyle(fontSize: 16,color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:   ColorConstant.lightGrayColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
