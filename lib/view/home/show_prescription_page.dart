import 'package:doctor_apk/res/color_constant.dart';
import 'package:flutter/material.dart';

class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
leading: GestureDetector(
  onTap: (){
    Navigator.pop(context);
  },
    child: Icon(Icons.arrow_back,color: ColorConstant.whiteColor,)),
        title:  Text('Prescription',style: TextStyle(color: Colors.white),),
          backgroundColor: ColorConstant.lightGrayColor,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            /// Doctor Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr. Aman Chauhan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('MBBS, MD - Cardiology'),
                    Text('Reg. No: DMC-12345'),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  // backgroundImage: AssetImage('assets/doctor.jpg'),
                )
              ],
            ),
            Divider(height: 30, thickness: 1),

            /// Patient Info
            Text('Patient Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name: John Doe'),
                Text('Age: 28'),
                Text('Gender: Male'),
              ],
            ),
            SizedBox(height: 10),
            Text('Date: 11 July 2025'),

            Divider(height: 30, thickness: 1),

            /// Symptoms
            Text('Symptoms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text('- Headache\n- Fatigue\n- Mild Fever'),

            Divider(height: 30, thickness: 1),

            /// Prescription
            Text('Prescription', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              '1. Paracetamol 500mg – 1 tablet twice a day after meal\n'
                  '2. ORS – 1 packet in 1L water\n'
                  '3. Rest for 2 days\n',
            ),

            Divider(height: 30, thickness: 1),

            /// Notes
            Text('Doctor\'s Notes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              'Patient advised to hydrate well and take rest.\n'
                  'Follow-up in 3 days if symptoms persist.',
            ),

            Spacer(),

            /// Signature
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Signature', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 40),
                  Text('Dr. Aman Chauhan'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
