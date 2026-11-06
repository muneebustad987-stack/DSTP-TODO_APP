import 'package:flutter/material.dart';
import 'package:my_multi_screen_project/constant/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.taskCardBgColor,
        border: Border.all(width: 1.5, color: AppColors.taskCardBorderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.primaryText, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarColor,
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.appbarColor,
                    child: Text(
                      "MS",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Muneeb Sheikh",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  Text(
                    "Grade 8 • Section B",
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Stats row: teen cards barabar width mein
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(child: _statCard("12", "Quizzes")),
                        const SizedBox(width: 10),
                        Expanded(child: _statCard("82%", "Avg score")),
                        const SizedBox(width: 10),
                        Expanded(child: _statCard("#5", "Class rank")),
                      ],
                    ),
                  ),

                  // Info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.taskCardBgColor,
                      border: Border.all(
                        width: 1,
                        color: AppColors.taskCardBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const InfoRow(
                          icon: Icons.email,
                          label: "Email",
                          value: "muneeb.sheikh@gmail.com",
                        ),
                        Divider(
                          color: AppColors.secondaryText,
                          endIndent: 10,
                          indent: 10,
                        ),
                        const InfoRow(
                          icon: Icons.school,
                          label: "College",
                          value: "S.M Govt College",
                        ),
                        Divider(
                          color: AppColors.secondaryText,
                          endIndent: 10,
                          indent: 10,
                        ),
                        const InfoRow(
                          icon: Icons.calendar_month_sharp,
                          label: "Joined",
                          value: "September 2026",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Actions card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.taskCardBgColor,
                      border: Border.all(
                        width: 1,
                        color: AppColors.taskCardBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Actions",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Icon(
                              Icons.notifications_none_outlined,
                              color: AppColors.secondaryText,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Notifications",
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.secondaryText,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Icon(
                              Icons.logout_outlined,
                              color: AppColors.cancelIconColor,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                  color: AppColors.cancelIconColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable row: icon + label + value (value lamba ho to ... ke saath kat jata hai)
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondaryText, size: 20),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: AppColors.primaryText)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.primaryText, fontSize: 15),
          ),
        ),
      ],
    );
  }
}