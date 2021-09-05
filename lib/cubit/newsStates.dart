abstract class newsStates {}

class newsInitialState extends newsStates {}

class changeNavBottomIndexState extends newsStates {}

class loadDataSuccessfullyState extends newsStates {}

class loadDataErrorState extends newsStates {
  final String error;
  loadDataErrorState(this.error);
}

class loadingBusinessIndicatorState extends newsStates {}

class loadSportDataSuccessfullyState extends newsStates {}

class loadSportDataErrorState extends newsStates {
  final String error;
  loadSportDataErrorState(this.error);
}

class loadingSportIndicatorState extends newsStates {}

class loadSienceDataSuccessfullyState extends newsStates {}

class loadSienceDataErrorState extends newsStates {
  final String error;
  loadSienceDataErrorState(this.error);
}

class loadingSienceIndicatorState extends newsStates {}

class changeThemeMoodState extends newsStates {}

class loadSearchDataSuccessfullyState extends newsStates {}

class loadSearchDataErrorState extends newsStates {
  final String error;
  loadSearchDataErrorState(this.error);
}

class loadingSearchIndicatorState extends newsStates {}
