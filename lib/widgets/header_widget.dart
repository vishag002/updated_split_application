import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:updated_split_application/utilis/app_dimensions.dart';
import 'package:updated_split_application/utilis/color_const.dart';
import 'package:updated_split_application/utilis/text_style_const.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;
  final double totalDue;
  final double totalToGet;

  const HeaderWidget({
    super.key,
    required this.userName,
    required this.totalDue,
    required this.totalToGet,
  });

  @override
  Widget build(BuildContext context) {
    final dateToday = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      height: AppDimensions.heightPercentage(20),
      width: AppDimensions.widthPercentage(100),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row: User name and today's date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: AppTextStyles.headingStyle.copyWith(
                  color: AppColors.buttonTextColor,
                ),
              ),
              Text(
                dateToday,
                style: AppTextStyles.captionStyle.copyWith(
                  color: AppColors.buttonTextColor.withOpacity(0.7),
                ),
              ),
            ],
          ),

          const Spacer(),

          /// Bottom section: Total Due and Total to Get
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmountLabel("Total Due", totalDue, Colors.redAccent),
              _buildAmountLabel("Total to Get", totalToGet, Colors.greenAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountLabel(String label, double amount, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionStyle.copyWith(
            color: AppColors.buttonTextColor.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "₹${amount.toStringAsFixed(2)}",
          style: AppTextStyles.subHeadingStyle.copyWith(
            color: valueColor,
            fontWeight: AppTextStyles.boldWeight,
          ),
        ),
      ],
    );
  }
}
