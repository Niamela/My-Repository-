import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../model/usermodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topMenuBar(context),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SizedBox(
                          height: 20.sp,
                          width: 20.sp,
                          child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data available'));
                }
                UserModel user = UserModel(
                  name: snapshot.data!.data()!['name'],
                  email: snapshot.data!.data()!['email'],
                  mobileNumber: snapshot.data!.data()!['mobileNumber'],
                );
                return Column(
                  children: [
                    Text("${user.name}"),
                    Text("${user.email}"),
                    Text(
                      "${user.mobileNumber}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
