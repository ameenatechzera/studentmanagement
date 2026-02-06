import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:studentmanagement/fetaures/authentication/presentation/screens/main_splash.dart';
import 'package:studentmanagement/services/service_locator.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

import 'core/theme/colors.dart';

import 'fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';

// late final AppDatabase appDb;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.theme,
      statusBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Brightness.dark,
    ),
  );
  // appDb = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  await ServiceLocator.init();
  final sharedPrefHelper = SharedPreferenceHelper();

  // set the default URL if not already set
  final currentBaseUrl = await sharedPrefHelper.getBaseUrl();
  if (currentBaseUrl == null) {
    await sharedPrefHelper.setBaseUrl(
      'https://techzera.in/quikSERV_Api/public/api',
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => sl<LoginCubit>()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QuikSERV',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.theme,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        home: const MainSplashScreen(),
      ),
    );
  }
}
