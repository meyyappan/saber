
import 'package:flutter/material.dart';
import 'package:nextcloud/nextcloud.dart';
import 'package:saber/data/nextcloud/nextcloud_client_extension.dart';

class NextcloudProfile extends StatefulWidget {
  const NextcloudProfile({Key? key}) : super(key: key);

  @override
  State<NextcloudProfile> createState() => _NextcloudProfileState();
}

class _NextcloudProfileState extends State<NextcloudProfile> {

  bool? loggedIn;
  String username = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future getUserInfo() async {
    final userInfo = await NextCloudClientExtension.fromSavedDetails();

    final UserData user;
    try {
      user = await userInfo.user.getUser();
    } catch (e) {
      return setState(() {
        loggedIn = false;
      });
    }

    return setState(() {
      loggedIn = true;
      username = user.displayName;
    });
  }

  @override
  Widget build(BuildContext context) {
    String heading = " " * 10, subheading = " " * 25;
    if (loggedIn == true) {
      heading = username;
      subheading = "Logged in with Nextcloud";
    } else if (loggedIn == false) {
      heading = "Logged out";
      subheading = "Tap to log in with Nextcloud";
    }

    var colorScheme = Theme.of(context).colorScheme;
    return Material(
      child: InkWell(
        onTap: () {
          // todo: login with nextcloud
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 50),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(heading),
                  Text(subheading, style: TextStyle(color: colorScheme.secondary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
