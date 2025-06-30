import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:updated_split_application/group/provider/providers_.dart';
import 'package:updated_split_application/group/screens/split_amount_screen.dart';
import 'package:updated_split_application/utilis/app_components.dart';
import 'package:updated_split_application/utilis/color_const.dart';
import 'package:updated_split_application/utilis/text_style_const.dart';

class AddMembersScreen extends ConsumerStatefulWidget {
  const AddMembersScreen({super.key});

  @override
  ConsumerState<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends ConsumerState<AddMembersScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger contact fetch once when screen is initialized
    Future.microtask(() => ref.read(contactProvider.notifier).fetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    final contactState = ref.watch(contactProvider);
    final contactController = ref.read(contactProvider.notifier);

    return Scaffold(
      appBar: AppComponents.appBarStyleWithIconButton(
        title: "Add Members",
        icon: Icon(Icons.check),
        onTapFunction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SplitAmountScreen()),
          );
        },
      ),

      body: Column(
        children: [
          if (contactState.permissionDenied)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Permission denied to read contacts."),
            ),
          if (!contactState.permissionDenied)
            Expanded(
              child: contactState.contacts.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: contactState.contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contactState.contacts[index];
                        final isSelected = contactState.selectedIndices
                            .contains(index);

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                contact.displayName.isNotEmpty
                                    ? contact.displayName[0]
                                    : '?',
                                style: AppTextStyles.subHeadingStyle.copyWith(
                                  color: AppColors.buttonTextColor,
                                ),
                              ),
                            ),
                            title: Text(
                              contact.displayName,
                              style: AppTextStyles.bodyStyle,
                            ),
                            subtitle: contact.phones.isNotEmpty
                                ? Text(
                                    contact.phones.first.number,
                                    style: AppTextStyles.captionStyle,
                                  )
                                : null,
                            trailing: Checkbox(
                              value: isSelected,
                              activeColor: AppColors.primaryColor,
                              onChanged: (_) =>
                                  contactController.toggleSelection(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),

          if (contactState.selectedIndices.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Members:",
                    style: AppTextStyles.subHeadingStyle,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: contactState.selectedIndices.map((index) {
                      final contact = contactState.contacts[index];
                      return Chip(
                        label: Text(contact.displayName),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () =>
                            contactController.removeSelected(index),
                        backgroundColor: AppColors.primaryColor.withOpacity(
                          0.1,
                        ),
                        labelStyle: AppTextStyles.captionStyle.copyWith(
                          color: AppColors.primaryTextColor,
                          fontWeight: AppTextStyles.mediumWeight,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
