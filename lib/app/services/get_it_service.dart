import 'package:get_it/get_it.dart';
import 'package:simple_chat/src/auth/application/auth_handler.dart';
import 'package:simple_chat/src/auth/application/authenticator.dart';
import 'package:simple_chat/src/auth/domain/auth_repository.dart';
import 'package:simple_chat/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:simple_chat/src/message/application/message_service.dart';
import 'package:simple_chat/src/message/domain/message_repository.dart';
import 'package:simple_chat/src/message/infrastructure/firebase_message_repository.dart';
import 'package:simple_chat/src/user_detail/application/user_detail_service.dart';
import 'package:simple_chat/src/user_detail/domain/user_detail_repository.dart';
import 'package:simple_chat/src/user_detail/infrastructure/firebase_user_detail_repository.dart';
import 'package:simple_chat/src/user_detail_message/application/user_detail_message_service.dart';
import 'package:simple_chat/src/user_detail_message/domain/user_detail_message_repository.dart';
import 'package:simple_chat/src/user_detail_message/infrastructure/firebase_user_detail_message_repository.dart';

GetIt getIt = GetIt.instance;

void setUpGetIt() {
  // Repositories.
  getIt.registerSingleton<IAuthRepository>(const FirebaseAuthRepository());
  getIt.registerSingleton<IUserDetailRepository>(
    const FirebaseUserDetailRepository(),
  );
  getIt.registerSingleton<IMessageRepository>(
    const FirebaseMessageRepository(),
  );
  getIt.registerSingleton<IUserDetailMessageRepository>(
    const FirebaseUserDetailMessageRepository(),
  );
  // Services.
  getIt.registerLazySingleton(() => AuthHandler(getIt<IAuthRepository>()));
  getIt.registerLazySingleton<UserDetailService>(
    () => UserDetailService(getIt<IUserDetailRepository>()),
  );
  getIt.registerLazySingleton(
    () => MessageService(
      getIt<IMessageRepository>(),
      getIt<IUserDetailRepository>(),
    ),
  );
  getIt.registerLazySingleton(
    () => UserDetailMessageService(getIt<IUserDetailMessageRepository>()),
  );
  getIt.registerFactory<Authenticator>(
    () => Authenticator(
      getIt<IAuthRepository>(),
      getIt<IUserDetailRepository>(),
    ),
  );
}
