abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppDatabaseInitialized extends AppStates {}

class AppDatabaseTableCreated extends AppStates {}

class AppDatabaseOpened extends AppStates {}

class AppDatabaseUserCreated extends AppStates {}

class AppDatabaseLoading extends AppStates {}

class AppDatabaseUsers extends AppStates {}

class AppSelectUser extends AppStates {}

class TaskColorChanged extends AppStates {}