import 'dart:io';

import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';
import 'package:test1/features/counter/presentation/pages/counter_page.dart';
import 'package:test1/features/login/presentation/pages/login_page.dart';
import 'package:test1/features/users/presentation/pages/users_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc()..initDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // supportedLocales: const [
        //   Locale("en"),
        // ],
        // localizationsDelegates: const [
        //   CountryLocalizations.delegate,
        // ],
        home: const UsersPage(),
      ),
    );
  }
}