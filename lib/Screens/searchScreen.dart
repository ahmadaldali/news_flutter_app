import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/Layout/newsLayout.dart';
import 'package:newsapp/cubit/newsCubit.dart';
import 'package:newsapp/cubit/newsStates.dart';
import 'package:newsapp/shared/components/components.dart';

class searchScreen extends StatelessWidget {
  TextEditingController searchCon = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        var search = newsCubit.get(ctx).search;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => newsLayoutScreen()));
              },
              icon: Icon(Icons.arrow_back),
              color: newsCubit.get(context).tm == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: searchCon,
                    decoration: InputDecoration(
                      labelText: "Search",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: newsCubit.get(context).tm == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      hintText: "Type to search",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: newsCubit.get(context).tm == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: newsCubit.get(context).tm == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (dynamic val) {
                      if (val.isEmpty) {
                        return "Search must not be empty";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (!formkey.currentState!.validate()) {
                        return;
                      } else {
                        newsCubit.get(context).getSearchedData(value);
                      }
                    },
                    cursorColor: newsCubit.get(context).tm == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                    style: TextStyle(
                      color: newsCubit.get(context).tm == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ConditionalBuilder(
                condition: search.length > 0,
                builder: (_) => ListView.separated(
                  itemBuilder: (ctx, index) => businessItem(search[index], ctx),
                  separatorBuilder: (ctx, index) => dividerItem(),
                  itemCount: search.length,
                ),
                fallback: (_) => Container(),
              ))
            ],
          ),
        );
      },
    );
  }
}
