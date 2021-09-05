import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/newsCubit.dart';
import 'package:newsapp/cubit/newsStates.dart';
import 'package:newsapp/shared/components/components.dart';

class sportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          List<dynamic> sport = newsCubit.get(ctx).sports;
          return ConditionalBuilder(
            condition: sport.length > 0,
            builder: (_) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, index) => businessItem(sport[index], ctx),
              separatorBuilder: (ctx, index) => dividerItem(),
              itemCount: sport.length,
            ),
            fallback: (_) => Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          );
        });
  }
}
