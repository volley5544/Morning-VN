part of 'page_result_bloc.dart';

abstract class PageResultState extends Equatable {
  final bool isButtonNavigatorShow;
  late int currentIndex;
  late bool isSuggestionpageShown;
  PageResultState(this.isButtonNavigatorShow, this.currentIndex,
      this.isSuggestionpageShown);

  @override
  List<Object> get props => [PageResultInitial];
}

class PageResultInitial extends PageResultState {
  PageResultInitial(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}

class Homepage extends PageResultState {
  Homepage(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}

class RoutingPage extends PageResultState {
  RoutingPage(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}

class ButtonNavigator extends PageResultState {
  ButtonNavigator(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}

class SetCompleted extends PageResultState {
  SetCompleted(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}

class SetNavIndexComplete extends PageResultState {
  SetNavIndexComplete(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}

class SetNavIndexLoading extends PageResultState {
  SetNavIndexLoading(super.isButtonNavigatorShow, super.currentIndex,
      super.isSuggestionpageShown);
}
