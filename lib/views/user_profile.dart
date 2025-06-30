import 'package:flutter/material.dart';
import 'package:updated_split_application/utilis/color_const.dart';
import 'package:updated_split_application/utilis/text_style_const.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              UserHeaderWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ProdileSection(),
            ],
          ),
        ),
      ),
    );
  }
}

//
class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://img.freepik.com/premium-vector/character-avatar-isolated_729149-194801.jpg?semt=ais_hybrid',
          ),
        ),
        const SizedBox(height: 16),
        Text("John Doe", style: AppTextStyles.headingStyle.copyWith()),
        const SizedBox(height: 8),
        Text(
          "john.doe@gmail.com",
          style: AppTextStyles.bodyStyle.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

//
class ProdileSection extends StatelessWidget {
  const ProdileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileMenuItem(
          icon: Icons.edit,
          title: "Edit Profile",
          onTap: () {
            // TODO: Navigate to Edit Profile Screen
          },
        ),
        const Divider(),
        _buildProfileMenuItem(
          icon: Icons.lock,
          title: "Security",
          onTap: () {
            // TODO: Navigate to Security Screen
          },
        ),
        const Divider(),
        _buildProfileMenuItem(
          icon: Icons.support_agent,
          title: "Customer Support",
          onTap: () {
            // TODO: Navigate to Customer Support Screen
          },
        ),
        const Divider(),
        _buildProfileMenuItem(
          icon: Icons.help_outline,
          title: "FAQ",
          onTap: () {
            // TODO: Navigate to FAQ Screen
          },
        ),
        const Divider(),
        _buildProfileMenuItem(
          icon: Icons.share,
          title: "Share App",
          onTap: () {
            // TODO: Implement share functionality
          },
        ),
        const Divider(),
        _buildProfileMenuItem(
          icon: Icons.logout,
          title: "Logout",
          onTap: () {
            // navigationAction();
          },
          isLogout: true,
        ),
      ],
    );
  }
}

//

Widget _buildProfileMenuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isLogout = false,
}) {
  return ListTile(
    leading: Icon(icon, color: isLogout ? Colors.red : null),
    title: Text(
      title,
      style: isLogout
          ? AppTextStyles.subHeadingStyle.copyWith(color: Colors.red)
          : AppTextStyles.subHeadingStyle,
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}
