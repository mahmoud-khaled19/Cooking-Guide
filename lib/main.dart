import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/theme_manager.dart';
import 'package:food_app/view/auth_screens/user_login_states_screen.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/view_model/app_cubit/bloc%20observer.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/view_model/register_cubit/register_cubit.dart';
import 'package:food_app/view_model/search_view_model/search_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit()
            ..getMealsCategory()
            ..getMealsArea(),
        ),
        BlocProvider<LoginCubit>(
            create: (BuildContext context) => LoginCubit()..getUserData()),
        BlocProvider<SearchCubit>(
            create: (BuildContext context) => SearchCubit()),
        BlocProvider<RegisterCubit>(
            create: (BuildContext context) => RegisterCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: getLightApplicationTheme(),
            home: UserLoginStates(),
          );
        },
      ),
    );
  }
}
