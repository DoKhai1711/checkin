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
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Cài đặt",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.green.shade500,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            title: "Rút tiền",
            icon: const Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            onTap: () {
              showToast(
                message: "Chức năng này đang trong quá trình phát triển",
                color: Colors.red,
              );
            },
          ),
          const Divider(
            height: 1,
          ),
          menuItem(
            title: "Nạp tiền",
            icon: const Icon(
              Icons.money,
              color: Colors.green,
            ),
            onTap: () {
              showToast(
                message: "Chức năng này đang trong quá trình phát triển",
                color: Colors.red,
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
