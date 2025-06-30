// Handles:

// State for creating a group

// Adding members

// Calculating split amounts

// Submitting group + member data to Supabase

// Should use StateNotifier or AsyncNotifier with Riverpod`

///
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupInfoController extends StateNotifier<GroupInfo> {
  GroupInfoController() : super(const GroupInfo());

  void setGroupName(String name) {
    state = state.copyWith(groupName: name);
  }

  void setTotalAmount(double amount) {
    state = state.copyWith(totalAmount: amount);
  }

  void setSplitType(String type) {
    state = state.copyWith(splitType: type);
  }
}

//
class GroupInfo {
  final String groupName;
  final double totalAmount;
  final String splitType; // 'equal' or 'custom'

  const GroupInfo({
    this.groupName = '',
    this.totalAmount = 0.0,
    this.splitType = 'equal',
  });

  GroupInfo copyWith({
    String? groupName,
    double? totalAmount,
    String? splitType,
  }) {
    return GroupInfo(
      groupName: groupName ?? this.groupName,
      totalAmount: totalAmount ?? this.totalAmount,
      splitType: splitType ?? this.splitType,
    );
  }
}
