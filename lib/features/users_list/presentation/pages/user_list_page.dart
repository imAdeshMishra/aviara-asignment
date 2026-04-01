import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aviara/features/users_list/presentation/bloc/user_event.dart';
import 'package:aviara/features/users_list/presentation/pages/user_details.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final TextEditingController _searchController = TextEditingController();
  String query = "";
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [const Text("Users List")]),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),

          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: "Search by name, email, or company",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce!.cancel();

          _debounce = Timer(const Duration(milliseconds: 300), () {
            setState(() {
              query = value.toLowerCase();
            });
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoaded && state.isFromCache) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Failed to fetch latest data. Showing cached data.",
              ),
            ),
          );
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {
            final users = state.users;

            final filteredUsers = users.where((user) {
              return user.name.toLowerCase().contains(query) ||
                  user.email.toLowerCase().contains(query) ||
                  user.company.name.toLowerCase().contains(query);
            }).toList();

            if (filteredUsers.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("No users found"),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(GetUsersEvent());
              },
              child: ListView.builder(
                itemCount: filteredUsers.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // 👇 LOAD MORE BUTTON
                  if (index == filteredUsers.length) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserBloc>().add(LoadMoreUsersEvent());
                        },
                        child: const Text("Load More"),
                      ),
                    );
                  }

                  final user = filteredUsers[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(user.name[0])),
                      title: Text(user.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(user.email), Text(user.address.city)],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserDetailPage(user: user),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }

          if (state is UserEmpty) {
            return const Center(child: Text("No users available"));
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(GetUsersEvent());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
