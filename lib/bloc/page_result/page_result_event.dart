part of 'page_result_bloc.dart';

abstract class PageResultEvent extends Equatable {
  const PageResultEvent();

  @override
  List<Object> get props => [];
}

class SetPageState extends PageResultEvent {
  final String pageName;
  const SetPageState(this.pageName);
}

class SetButtonNavigator extends PageResultEvent {
  final bool isShow;
  const SetButtonNavigator(this.isShow);
}

class SetCurrentNavBarIndex extends PageResultEvent {
  final int currentIndex;
  const SetCurrentNavBarIndex(this.currentIndex);
}

class SetIsSuggestionPageShown extends PageResultEvent {
  final bool isSuggestionpageShown;
  const SetIsSuggestionPageShown(this.isSuggestionpageShown);
}
