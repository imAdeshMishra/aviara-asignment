import 'package:flutter/material.dart';
import 'package:aviara/features/users_list/domain/entities/user.dart';

class UserDetailPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [const Text("User Details")]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem("Name", user.name),
            _buildItem("Email", user.email),
            _buildItem("Phone", user.phone),
            _buildItem("Website", user.website),
            _buildItem("Company", user.company.name),
            _buildItem(
              "Complete Address",
              user.address.suite +
                  ", " +
                  user.address.street +
                  ", " +
                  user.address.city +
                  ", " +
                  user.address.zipcode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 4),

          Text(value, style: const TextStyle(fontSize: 16)),

          const Divider(),
        ],
      ),
    );
  }
}
