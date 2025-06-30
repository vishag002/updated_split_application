//UI to choose between Equal or Custom split and adjust amounts.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:updated_split_application/group/provider/providers_.dart';
import 'package:updated_split_application/utilis/app_components.dart';
import 'package:updated_split_application/utilis/color_const.dart';
import 'package:updated_split_application/utilis/text_style_const.dart';
import 'package:updated_split_application/views/bottom_nav_screen.dart';

class SplitAmountScreen extends ConsumerWidget {
  const SplitAmountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInfo = ref.watch(groupInfoProvider);
    final contactState = ref.watch(contactProvider);
    final selectedContacts = contactState.selectedIndices.map((index) {
      final contact = contactState.contacts[index];
      return {
        'name': contact.displayName,
        'phone': contact.phones.isNotEmpty ? contact.phones.first.number : '',
      };
    }).toList();
    return Scaffold(
      appBar: AppComponents.appBarStyleWithTitle("Split Amount", context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Top Info
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Group Name : ${groupInfo.groupName}",
                style: AppTextStyles.headingStyle,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total Amount: ₹${groupInfo.totalAmount.toStringAsFixed(2)}",
                style: AppTextStyles.subHeadingStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Table Section
            Expanded(child: GroupMemberAmountTable(members: selectedContacts)),

            /// Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle confirmation logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Group confirmed!")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PopScope(canPop: false, child: BottomNavBarScreen()),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Confirm",
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
}

//
class GroupMemberAmountTable extends StatelessWidget {
  final List<Map<String, dynamic>> members;

  const GroupMemberAmountTable({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Table Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColors.primaryColor.withOpacity(0.1),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Name & Phone",
                  style: AppTextStyles.subHeadingStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("Amount", style: AppTextStyles.subHeadingStyle),
              ),
            ],
          ),
        ),

        const Divider(height: 0, thickness: 1, color: AppColors.borderColor),

        /// Scrollable Table Rows
        Expanded(
          child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name'],
                                style: AppTextStyles.bodyStyle,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member['phone'],
                                style: AppTextStyles.captionStyle,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController(
                              text: "₹${member['amount']}",
                            ),
                            style: AppTextStyles.bodyStyle,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundColor,
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: AppColors.borderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                    color: AppColors.borderColor,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
