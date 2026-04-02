import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:studentmanagement/fetaures/authentication/presentation/screens/main_splash.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
import 'package:studentmanagement/fetaures/materials/presentation/cubit/material_cubit.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/cubit/timetable_cubit.dart';
import 'package:studentmanagement/services/service_locator.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

import 'core/theme/colors.dart';

import 'fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';

// late final AppDatabase appDb;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: AppColors.theme,
  //     statusBarIconBrightness: Brightness.dark,
  //     //statusBarBrightness: Brightness.dark,
  //   ),
  // );
  // appDb = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  await ServiceLocator.init();
  final sharedPrefHelper = SharedPreferenceHelper();

  // set the default URL if not already set
  final currentBaseUrl = await sharedPrefHelper.getBaseUrl();
  if (currentBaseUrl == null) {
    await sharedPrefHelper.setBaseUrl(
      // 'https://cristalofflineweb.techzera.in/Api/public/api',
      //'https://test.cristaledu.com/Api/public/api',
      //'https://cristalwebonline.techzera.in/Api/public/api',
      'https://online.cristaledu.com/Api/public/api',
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
        BlocProvider<TimetableCubit>(create: (_) => sl<TimetableCubit>()),
        BlocProvider<DiaryCubit>(create: (_) => sl<DiaryCubit>()),
        BlocProvider<FeesCubit>(create: (_) => sl<FeesCubit>()),
        BlocProvider<UnPaidFeeCubit>(create: (_) => sl<UnPaidFeeCubit>()),
        BlocProvider<FeedCubit>(create: (_) => sl<FeedCubit>()),
        BlocProvider<MarklistCubit>(create: (_) => sl<MarklistCubit>()),
        BlocProvider<MaterialCubit>(create: (_) => sl<MaterialCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cristal',
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
