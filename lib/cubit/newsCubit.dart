import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Screens/businessScreen.dart';
import 'package:newsapp/Screens/scienseScreen.dart';
import 'package:newsapp/Screens/settingsScreen.dart';
import 'package:newsapp/Screens/sportScreen.dart';
import 'package:newsapp/cubit/newsStates.dart';
import 'package:newsapp/network/local/cachedHelper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

class newsCubit extends Cubit<newsStates> {
  newsCubit() : super(newsInitialState());

  static newsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  List<Widget> screens = [
    businessScreen(),
    sportScreen(),
    scienseScreen(),
    settingsScreen(),
  ];

  void changeNavBottomIndex(int index) {
    currentIndex = index;
    emit(changeNavBottomIndexState());
  }

  List<dynamic> business = [];
  void loadData() {
    emit(loadingBusinessIndicatorState());
    if (business.length == 0) {
      DioHelper.getdata(
        url: 'v2/top-headlines',
        query: {
          "country": "eg",
          "category": "business",
          "apikey": "433ad5d1116d4a5c96ab281b992d04e0",
        },
      ).then((value) {
        business = value.data['articles'];

        emit(loadDataSuccessfullyState());
      }).catchError((error) {
        emit(loadDataErrorState(error.toString()));
      });
    } else {
      emit(loadDataSuccessfullyState());
    }
  }

  List<dynamic> sports = [];
  void loadSportsData() {
    emit(loadingSportIndicatorState());

    if (sports.length == 0) {
      DioHelper.getdata(
        url: 'v2/top-headlines',
        query: {
          "country": "eg",
          "category": "sports",
          "apikey": "433ad5d1116d4a5c96ab281b992d04e0",
        },
      ).then((value) {
        sports = value.data['articles'];

        emit(loadSportDataSuccessfullyState());
      }).catchError((error) {
        emit(loadSportDataErrorState(error.toString()));
      });
    } else {
      emit(loadSportDataSuccessfullyState());
    }
  }

  List<dynamic> science = [];
  void loadScienceData() {
    emit(loadingSienceIndicatorState());

    if (science.length == 0) {
      DioHelper.getdata(
        url: 'v2/top-headlines',
        query: {
          "country": "eg",
          "category": "science",
          "apikey": "433ad5d1116d4a5c96ab281b992d04e0",
        },
      ).then((value) {
        science = value.data['articles'];

        emit(loadSienceDataSuccessfullyState());
      }).catchError((error) {
        emit(loadSienceDataErrorState(error.toString()));
      });
    } else {
      emit(loadSienceDataSuccessfullyState());
    }
  }

  ThemeMode tm = ThemeMode.light;

  void changeThemeMood(ThemeMode newTm) {
    tm = newTm;
    cacheHelper()
        .setCachedMood(
            key: 'isDark', value: tm == ThemeMode.light ? false : true)
        .then((value) {
      emit(changeThemeMoodState());
    });
  }

  List<dynamic> search = [];

  void getSearchedData(String value) {
    emit(loadingSearchIndicatorState());

    DioHelper.getdata(
      url: 'v2/everything',
      query: {
        "q": "$value",
        "apikey": "433ad5d1116d4a5c96ab281b992d04e0",
      },
    ).then((value) {
      search = value.data['articles'];

      emit(loadSearchDataSuccessfullyState());
    }).catchError((error) {
      emit(loadSearchDataErrorState(error.toString()));
    });
  }
}
