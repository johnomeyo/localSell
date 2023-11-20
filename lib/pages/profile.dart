import 'package:flutter/material.dart';
import 'package:local_sell/auth/sign_up.dart';
import 'package:local_sell/components/beta.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/components/gamma.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: backgroundColor,
            actions: const [
              SearchButton(),
            ],
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                          const Text(
                            "Astropphel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "test@gmail.com",
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpPage())),
                    child: const ProfileTiles(
                        title: "Edit Profile", text: "Change your details"),
                  ),
                  // const ProfileTiles(
                  //     title: "My Orders", text: "Already have 12 orders"),
                  const ProfileTiles(title: "Payment Method", text: "Mpesa"),
                  const ProfileTiles(title: "Telephone", text: "0729822061"),
                  const ProfileTiles(
                      title: "Settings", text: "Notifications, Password"),
                ],
              ),
            ),
          )),
    );
  }
}
