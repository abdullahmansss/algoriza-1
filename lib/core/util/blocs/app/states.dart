import 'package:test1/core/error/exceptions.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class UserLoginLoadingState extends AppStates {}

class UserLoginSuccessState extends AppStates {}

class UserProfileLoadingState extends AppStates {}

class UserProfileSuccessState extends AppStates {}

class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class ToggleIsEndState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}