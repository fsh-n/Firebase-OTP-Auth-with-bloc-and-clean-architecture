import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_otp_auth/features/authentication/bloc/login_bloc.dart';
import 'package:firebase_otp_auth/features/authentication/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/data/auth_repository_impl.dart';
import 'firebase_options.dart';

void main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final _authService = Auth(firebaseAuth: FirebaseAuth.instance);
      runApp(MaterialApp(
          home: BlocProvider(
              create: (context) => LoginBloc(authService: _authService),
              child: const AuthScreen())));
    },
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition); // Remove in production , just for testing purpose
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error); // Remove in production , just for testing purpose
    super.onError(bloc, error, stackTrace);
  }
}
