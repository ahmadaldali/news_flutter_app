import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Screens/searchScreen.dart';
import 'package:newsapp/cubit/newsCubit.dart';
import 'package:newsapp/cubit/newsStates.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

class newsLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        var cubit = newsCubit.get(ctx);
        return Scaffold(
          appBar: AppBar(
            title: (Text("News App")),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => searchScreen()));
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.tm == ThemeMode.dark
                      ? cubit.changeThemeMood(ThemeMode.light)
                      : cubit.changeThemeMood(ThemeMode.dark);
                },
                icon: Icon(
                  Icons.brightness_4_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.navBarItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBottomIndex(index);
            },
          ),
        );
      },
    );
  }
}
