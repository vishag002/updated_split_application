import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:updated_split_application/group/provider/providers_.dart';
import 'package:updated_split_application/group/screens/add_members_screen.dart';
import 'package:updated_split_application/utilis/app_components.dart';
import 'package:updated_split_application/utilis/color_const.dart';
import 'package:updated_split_application/utilis/text_style_const.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String selectedSplit = 'Equal';

  @override
  void dispose() {
    _groupNameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access Riverpod state using `ref` here
    final groupInfo = ref.watch(groupInfoProvider);

    return Scaffold(
      appBar: AppComponents.appBarStyleWithTitle(
        "Create Group",
        context,
        showBackButton: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Group Name
            Text("Group Name", style: AppTextStyles.subHeadingStyle),
            const SizedBox(height: 6),
            TextField(
              controller: _groupNameController,
              style: AppTextStyles.bodyStyle,
              decoration: InputDecoration(
                hintText: "Enter group name",
                hintStyle: AppTextStyles.captionStyle,
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Total Amount
            Text("Total Amount", style: AppTextStyles.subHeadingStyle),
            const SizedBox(height: 6),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.bodyStyle,
              decoration: InputDecoration(
                hintText: "Enter total amount",
                hintStyle: AppTextStyles.captionStyle,
                filled: true,
                fillColor: AppColors.cardColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Split Type Selector
            Text("Split Type", style: AppTextStyles.subHeadingStyle),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildSplitTypeButton("Equal"),
                const SizedBox(width: 10),
                _buildSplitTypeButton("Custom"),
              ],
            ),

            const Spacer(),

            /// Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final groupName = _groupNameController.text.trim();
                  final amount = double.tryParse(_amountController.text.trim());
                  final splitType = selectedSplit;
                  if (groupName.isEmpty || amount == null || amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter valid group details"),
                      ),
                    );
                    return;
                  }
                  //save state to riverpod
                  ref.read(groupInfoProvider.notifier).setGroupName(groupName);
                  ref.read(groupInfoProvider.notifier).setTotalAmount(amount);
                  ref.read(groupInfoProvider.notifier).setSplitType(splitType);
                  // print(groupInfo.groupName.toString());
                  // print(groupInfo.totalAmount);
                  // print(groupInfo.splitType);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMembersScreen()),
                  );
                  // Navigate to next screen with collected data
                },
                child: Text(
                  "Continue",
                  style: AppTextStyles.subHeadingStyle.copyWith(
                    color: AppColors.buttonTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitTypeButton(String type) {
    final isSelected = selectedSplit == type;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedSplit = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.borderColor,
            ),
          ),
          child: Center(
            child: Text(
              type,
              style: AppTextStyles.bodyStyle.copyWith(
                color: isSelected
                    ? AppColors.buttonTextColor
                    : AppColors.primaryTextColor,
                fontWeight: AppTextStyles.semiBoldWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
