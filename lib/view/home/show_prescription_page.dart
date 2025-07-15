import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/show_prescription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ShowPrescriptionViewModel>(context).modelData?.data;
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
      body:data!=null? Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            /// Doctor Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr.${data?.docName??""}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(data?.Qualification??""),
                    Text('Reg. No: ${data?.regNo??""}'),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(data?.image??""),
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
                Text('Name: ${data?.pratientName??""}'),
                Text('Age: ${data?.age??""}'),
                Text('Gender:${data?.gender??""}'),
              ],
            ),
            SizedBox(height: 10),
            // Text('Date: ${ DateFormat('EE, dd MMM').format(DateTime.parse(data?.createdAt.toString()??""))}'),

            Divider(height: 30, thickness: 1),

            /// Symptoms
            Text('Symptoms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            // Text('- Headache\n- Fatigue\n- Mild Fever'),
            Text('${data?.symptoms??""}'),

            Divider(height: 30, thickness: 1),

            /// Prescription
            Text('Prescription', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            // Text(
            //   '1. Paracetamol 500mg – 1 tablet twice a day after meal\n'
            //       '2. ORS – 1 packet in 1L water\n'
            //       '3. Rest for 2 days\n',
            // ),
Text("${data?.medicines??""}"),
            Divider(height: 30, thickness: 1),

            /// Notes
            Text('Doctor\'s Notes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            // Text(
            //   'Patient advised to hydrate well and take rest.\n'
            //       'Follow-up in 3 days if symptoms persist.',
            // ),
Text(data?.note??""),
            // Spacer(),

            // /// Signature
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       Text('Signature', style: TextStyle(fontWeight: FontWeight.bold)),
            //       SizedBox(height: 40),
            //       Text('Dr. Aman Chauhan'),
            //     ],
            //   ),
            // )
          ],
        ),
      ):Center(child: Text("No prescription added yet...")),
    );
  }
}
