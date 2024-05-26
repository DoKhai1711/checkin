import 'package:flutter/material.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/view/login/login_page.dart';
import 'package:untitled/view/profile/edit_profile/edit_profile_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset(
                  "assets/img/Paft.png",
                  width: 90,
                  height: 90,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                "Cài đặt",
                style: TextStyle(
                    color: Colors.green.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 33),
              )
            ],
          ),
          SizedBox(height: 40),
          const Divider(
            height: 1,
          ),
          menuItem(
            title: "Chỉnh sửa thông tin",
            icon: const Icon(
              Icons.person,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    arguments: EditProfileArguments(),
                  ),
                ),
              );
            },
          ),
          const Divider(
            height: 1,
          ),
          menuItem(
            title: "Đăng xuất",
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(arguments: LoginArguments()),
                ),
              );
            },
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget menuItem({
    required String title,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(title),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFB5B4B4),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
