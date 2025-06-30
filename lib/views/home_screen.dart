import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:updated_split_application/group/screens/create_group_screen.dart';
import 'package:updated_split_application/group/screens/group_details_screen.dart';
import 'package:updated_split_application/utilis/app_components.dart';
import 'package:updated_split_application/utilis/app_dimensions.dart';
import 'package:updated_split_application/utilis/color_const.dart';
import 'package:updated_split_application/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppComponents.appBarStyleWithTitle(
        "",
        context,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(totalDue: 500, totalToGet: 2500, userName: "Vicky"),
            ButtonRow(
              onSendReminder: () {
                //todo
              },
              onSettleDues: () {
                //todo
              },
            ),
            SplitListView(),
          ],
        ),
      ),
      floatingActionButton: AddSplitButton(),
    );
  }
}

// //
// class HeaderWidget extends StatelessWidget {
//   const HeaderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppDimensions.heightPercentage(20),
//       width: AppDimensions.widthPercentage(100),
//       decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(.8)),
//     );
//   }
// }

//
class ButtonRow extends StatelessWidget {
  final VoidCallback onSendReminder;
  final VoidCallback onSettleDues;

  const ButtonRow({
    super.key,
    required this.onSendReminder,
    required this.onSettleDues,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        height: AppDimensions.heightPercentage(10),
        width: AppDimensions.widthPercentage(95),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(.08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildButton("Reminder", onSendReminder),
            _buildButton("Settle Dues", onSettleDues),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: AppDimensions.heightPercentage(7),
        width: AppDimensions.widthPercentage(30),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

//
class SplitListView extends StatelessWidget {
  const SplitListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GroupDetailsScreen()),
          );
        },
        child: groupsCard(),
      ),
    );
  }
}
//

Widget groupsCard() {
  return Card(
    color: AppColors.secondaryColor,
    child: ListTile(
      leading: Container(
        height: AppDimensions.heightPercentage(12),
        width: AppDimensions.widthPercentage(12),
        decoration: const BoxDecoration(
          color: AppColors.buttonColor,
          shape: BoxShape.circle,
        ),
      ),
      title: const Text("Group Name"),
    ),
  );
}

//
class AddSplitButton extends StatelessWidget {
  const AddSplitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateGroupScreen()),
        );
      },
      child: const Icon(
        CupertinoIcons.add,
        weight: 100,
        size: 30,
        color: AppColors.secondaryColor,
      ),
    );
  }
}
