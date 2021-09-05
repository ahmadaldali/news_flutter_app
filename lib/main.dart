import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/Layout/newsLayout.dart';
import 'package:newsapp/cubit/newsCubit.dart';
import 'package:newsapp/cubit/newsStates.dart';
import 'package:newsapp/network/local/cachedHelper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

import 'cubit/bloCobserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await cacheHelper.init();
  bool isDark = cacheHelper().getCachedMood(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool mood;
  MyApp(this.mood);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => newsCubit()
          ..changeThemeMood(
            mood == false ? ThemeMode.light : ThemeMode.dark,
          )
          ..loadData()
          ..loadScienceData()
          ..loadSportsData(),
        child: BlocConsumer<newsCubit, newsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                title: 'news App',
                debugShowCheckedModeBanner: false,
                themeMode: newsCubit.get(context).tm,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      titleSpacing: 10,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 20.0,
                    selectedItemColor: Colors.deepOrange,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: HexColor("#1f1f1f"),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    bodyText2: TextStyle(
                      color: HexColor("#3d3d3d"),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    headline6: TextStyle(
                      color: HexColor("#5c5c5c"),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor("#3b3a43"),
                  appBarTheme: AppBarTheme(
                      titleSpacing: 10,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light,
                      ),
                      elevation: 0,
                      backgroundColor: HexColor("#3b3a43"),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 20.0,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: HexColor("#3b3a43"),
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: HexColor("#ececee"),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    bodyText2: TextStyle(
                      color: HexColor("#f9f9f7"),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    headline6: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                ),
                home: Directionality(
                  textDirection: TextDirection.ltr,
                  child: newsLayoutScreen(),
                ),
              );
            }));
  }
}
