import 'package:test1/core/error/exceptions.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class UserLoginLoadingState extends AppStates {}

class UserLoginSuccessState extends AppStates {}

class UserProfileLoadingState extends AppStates {}

class UserProfileSuccessState extends AppStates {}

class UserProfileUpdateLoadingState extends AppStates {}

class UserProfileUpdateSuccessState extends AppStates {}


class GetFacilitiesLoadingState extends AppStates {}

class GetFacilitiesSuccessState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SelectFacilityState extends AppStates {}

class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class ToggleIsEndState extends AppStates {}

class PickImageSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}