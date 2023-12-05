import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_sell/auth/auth_methods.dart';
import 'package:local_sell/auth/sign_up.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/components/gamma.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Profile",
                      style: style2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1564038079594-99ba184fd036?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y3V0ZSUyMGdpcmxzfGVufDB8fDB8fHww"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['username'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData['email'],
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage())),
                      child: const ProfileTiles(
                          title: "Edit Profile", text: "Change your details"),
                    ),
                    const ProfileTiles(title: "Payment Method", text: "Mpesa"),
                    ProfileTiles(title: "Telephone", text: userData['phone']),
                    const ProfileTiles(
                        title: "Settings", text: "Notifications, Password"),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: SizedBox(
                                      height: 80,
                                      child: Column(
                                        children: [
                                          const Text(
                                              "Are you sure you want to log out?"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text("Cancel")),
                                              const Spacer(),
                                              TextButton(
                                                  onPressed: () {
                                                    AuthMethods().signOut();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Yes")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: const Text(
                          "Log Out",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("An error ${snapshot.error.toString()} occured");
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        );
      },
    ));
  }
}
