import 'package:aviara/core/di/injection_container.dart';
import 'package:aviara/features/users_list/presentation/bloc/user_bloc.dart';
import 'package:aviara/features/users_list/presentation/bloc/user_event.dart';
import 'package:aviara/features/users_list/presentation/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              UserBloc(getUsersUseCase, userLocalDataSource)
                ..add(GetUsersEvent()),
        ),

        // 👉 Future blocs go here
        // BlocProvider(create: (_) => AnotherBloc(...)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersList(),
    );
  }
}
