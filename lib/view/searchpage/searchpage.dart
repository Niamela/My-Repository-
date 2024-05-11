import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/router/routes.dart';
import 'package:sizer/sizer.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? address;
  String? about_company;
  List<String>? services;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.about_company,
    this.address,
    this.services,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      about_company: json['about_company'],
      address: json['address'],
      services: json['services'] != null ? List.from(json['services']) : [],
    );
  }
}

class UserSearchPage extends StatefulWidget {
  String searchtxt;

  UserSearchPage({super.key, required this.searchtxt});

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<UserModel> searchResults = [];
  List<String> allAddresses = [];

  String? address;

  @override
  void initState() {
    super.initState();
    _fetchAllAddresses();
    _searchUsers(widget.searchtxt!, '');
    _searchController.text = widget.searchtxt!;
  }

  void _fetchAllAddresses() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          String address = userData['address'];
          if (!allAddresses.contains(address)) {
            allAddresses.add(address);
          }
        });
      });
    }).catchError((error) {
      print("Error fetching addresses: $error");
    });
  }

  void _searchUsers(String searchText, String selectedAddress) {
    searchResults.clear();
    if (selectedAddress == '') {
      FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: searchText)
          .get()
          .then((QuerySnapshot querySnapshot) {
        setState(() {
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
            UserModel user = UserModel.fromMap(userData);
            // Filter the results based on the search text
            if (user.name!.toLowerCase().contains(searchText.toLowerCase())) {
              searchResults.add(user);
            }
          });
        });
      }).catchError((error) {
        print("Error searching users: $error");
      });
      if (searchResults.isEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .where('services', arrayContains: searchText)
            .get()
            .then((QuerySnapshot querySnapshot) {
          setState(() {
            querySnapshot.docs.forEach((doc) {
              Map<String, dynamic> userData =
                  doc.data() as Map<String, dynamic>;
              UserModel user = UserModel.fromMap(userData);
              // Filter the results based on the search text

              searchResults.add(user);
            });
          });
        }).catchError((error) {
          print("Error searching users: $error");
        });
      }
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .where('address', isEqualTo: selectedAddress)
          .get()
          .then((QuerySnapshot querySnapshot) {
        setState(() {
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
            UserModel user = UserModel.fromMap(userData);
            // Filter the results based on the search text
            if (user.name!.toLowerCase().contains(searchText.toLowerCase())) {
              searchResults.add(user);
            }
            List<String> lowercaseServices =
                user.services!.map((service) => service.toLowerCase()).toList();
            if (lowercaseServices.contains(searchText.toLowerCase())) {
              searchResults.add(user);
            }
          });
        });
      }).catchError((error) {
        print("Error searching users: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: null,
                  onChanged: (selectedAddress) {
                    _searchUsers(_searchController.text, selectedAddress ?? '');
                    address = selectedAddress;
                  },
                  items: allAddresses.map((address) {
                    return DropdownMenuItem<String>(
                      value: address,
                      child: Text(address),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _searchUsers(value, address ?? '');
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    GoRouter.of(context).push(
                        '${AppRoutes.supplierProfileScreen}?query=${searchResults[index].id}');
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        searchResults[index].name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: isMobile ? 14.sp : 18.sp,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _buildFieldText('Email', searchResults[index].email),

                          _buildFieldText(
                              'Address', searchResults[index].address),
                          //  _buildFieldText('About Company',
                          //     searchResults[index].about_company),
                          _buildFieldText(
                              'Services',
                              searchResults[index].services != null
                                  ? searchResults[index].services!.join(', ')
                                  : 'N/A'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldText(String fieldName, String? value) {
    return Row(
      children: [
        Text(
          '$fieldName: ',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: mainColor, fontSize: 10.sp),
        ),
        SizedBox(
          width: 225.sp,
          child: Text(
            ' ${value ?? 'N/A'}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
          ),
        ),
      ],
    );
  }
}
