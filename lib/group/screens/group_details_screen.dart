import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final String currentUserName = "Ravi"; // change based on who is logged in
  final bool isAdmin = true; // change this to false to simulate normal user

  List<GroupMember> groupMembers = [
    GroupMember(name: "Manu", amount: 800),
    GroupMember(name: "Vicky", amount: 600, isSettled: true, isVerified: true),
    GroupMember(name: "Ravi", amount: 750),
    GroupMember(name: "Sita", amount: 500, isSettled: true),
    GroupMember(name: "Gita", amount: 350),
  ];

  void settleDue(GroupMember member) {
    setState(() {
      member.isSettled = true;
      member.isVerified = false;
    });
  }

  void verifyPayment(GroupMember member) {
    setState(() {
      member.isVerified = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip to Goa")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧾 Summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Total Amount: ₹3000"),
                Text("You Paid: ₹1000"),
                Text("Your Share: ₹750"),
                Text(
                  "You Get Back: ₹250",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          const Divider(),
          // 👥 Group Members
          Expanded(
            child: ListView.builder(
              itemCount: groupMembers.length,
              itemBuilder: (context, index) {
                final member = groupMembers[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(member.name[0])),
                    title: Text(member.name),
                    subtitle: Text("Owes ₹${member.amount.toStringAsFixed(2)}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!member.isSettled && member.name == currentUserName)
                          ElevatedButton(
                            onPressed: () => settleDue(member),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: const Text("Settle"),
                          ),
                        if (member.isSettled && !member.isVerified)
                          isAdmin
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.verified,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => verifyPayment(member),
                                  tooltip: "Verify payment",
                                )
                              : const Icon(
                                  Icons.hourglass_top,
                                  color: Colors.orange,
                                ),
                        if (member.isVerified)
                          const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GroupMember {
  final String name;
  final double amount;
  bool isSettled;
  bool isVerified;
  final String? comment;

  GroupMember({
    required this.name,
    required this.amount,
    this.isSettled = false,
    this.isVerified = false,
    this.comment,
  });
}
