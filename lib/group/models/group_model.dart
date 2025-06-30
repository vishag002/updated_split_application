//A data class for a group (name, category, total amount, createdBy, etc.).
class GroupModel {
  final String groupName;
  final int totalAmount;
  final String splitType;

  GroupModel({
    required this.groupName,
    required this.totalAmount,
    required this.splitType,
  });
}
