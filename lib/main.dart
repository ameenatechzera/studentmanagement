import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:studentmanagement/core/database/app_database.dart';
import 'package:studentmanagement/core/database/database_init.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/cubit/attendence_cubit.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/appstart_screen.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
import 'package:studentmanagement/fetaures/materials/presentation/cubit/material_cubit.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/cubit/timetable_cubit.dart';
import 'package:studentmanagement/services/service_locator.dart';
import 'fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';

//late AppDatabase db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("🚀 STEP 1: Flutter binding ready");
  await MediaStore.ensureInitialized();
  MediaStore.appFolder = "Cristal";
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: AppColors.theme,
  //     statusBarIconBrightness: Brightness.dark,
  //     //statusBarBrightness: Brightness.dark,
  //   ),
  // );
  // 1. CREATE DB FIRST
  // ✅ initialize Floor DB here
  // 1️⃣ INIT DB FIRST
  await DatabaseInit.init();

  print("🟢 STEP 2: DB initialized");
  await ServiceLocator.init();
  print("🟢 STEP 3: ServiceLocator ready");

  //final sharedPrefHelper = SharedPreferenceHelper();
  //db = await $FloorAppDatabase.databaseBuilder('app.db').build();
  // db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // set the default URL if not already set
  // final currentBaseUrl = await sharedPrefHelper.getBaseUrl();
  // if (currentBaseUrl == null) {
  //   // await sharedPrefHelper.setBaseUrl(
  //   //   // 'https://cristalofflineweb.techzera.in/Api/public/api',
  //   //   //'https://test.cristaledu.com/Api/public/api',
  //   //   //'https://cristalwebonline.techzera.in/Api/public/api',
  //   //   // 'https://online.cristaledu.com/Api/public/api/app',

  //   //   //'https://fsp.cristaledu.com/Api/public/api',
  //   //   'https://online.cristaledu.com/Api/public/api',
  //   // );
  // }
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint("🔥 FLUTTER ERROR");
    debugPrint(details.exceptionAsString());
    debugPrint(details.stack.toString());
  };
  runApp(MyApp());
  print("🟢 STEP 4: App started");
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
        BlocProvider<AttendenceCubit>(create: (_) => sl<AttendenceCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cristal',
        theme: ThemeData(
          fontFamily: 'TitilliumWeb',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            // systemOverlayStyle: SystemUiOverlayStyle(
            //   statusBarColor: AppColors.theme,
            //   statusBarIconBrightness: Brightness.dark,
            //   statusBarBrightness: Brightness.light,
            // ),
          ),
        ),
        home: const AppStartScreen(),
      ),
    );
  }
}
