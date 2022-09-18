import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/di/injection.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';
import 'package:test1/core/util/network/remote/dio_helper.dart';
import 'package:test1/core/util/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => sl<AppBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: false,
            systemOverlayStyle: Platform.isIOS
                ? null
                : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        routes: Routes.routes,
        initialRoute: Routes.home,
      ),
    );
  }
}

extension NavigationContext on BuildContext {
  get pop => Navigator.pop(this);
  set push(String page) => Navigator.pushNamed(this, page);
}