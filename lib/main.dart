
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/bloc/simple_bloc_delegate.dart';
import 'core/di/di.dart';
import 'core/resources/theme_manager.dart';
import 'features/splash_view.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isIOS){
  //   await Firebase.initializeApp();
  // }

  await initAppModule();
  setupBloc();

  runApp(
      const MyApp()
  );

}

void setupBloc() {
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          //translations: LocaleString(),
          debugShowCheckedModeBanner: false,
          locale: Locale('ar','EG'),
          theme: getApplicationTheme(),
          home: SplashView(),
        );
      },
    );
  }
}

