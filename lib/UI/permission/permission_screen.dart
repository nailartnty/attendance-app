import 'package:attendance/UI/permission/components/app_bar.dart';
import 'package:attendance/UI/permission/components/form_body.dart';
import 'package:attendance/UI/permission/components/form_header.dart';
import 'package:attendance/UI/permission/components/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  buildAppBar(context),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormHeader(
                title: "Permission Request Report", 
                icon: Icons.person_3_outlined
              ),
              const FormBody(),
              SubmitButton(
                size: size, 
                namaController: TextEditingController(), 
                formController: TextEditingController(), 
                toController: TextEditingController(), dropValueCategories: "Dropdown Content", 
                dataCollection: FirebaseFirestore.instance.collection('dataCollectionValue')
              )
            ],
          ),
        ),
      ),
    );
  }
}