import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_result_event.dart';
part 'page_result_state.dart';

class PageResultBloc extends Bloc<PageResultEvent, PageResultState> {
  PageResultBloc() : super(PageResultInitial(true, 0, true)) {
    on<SetPageState>((event, emit) {});
    on<SetButtonNavigator>((event, emit) {
      emit(ButtonNavigator(
          event.isShow, state.currentIndex, state.isSuggestionpageShown));
      emit(SetCompleted(
          event.isShow, state.currentIndex, state.isSuggestionpageShown));
    });
    on<SetCurrentNavBarIndex>((event, emit) {
      emit(SetNavIndexLoading(state.isButtonNavigatorShow, state.currentIndex,
          state.isSuggestionpageShown));
      state.currentIndex = event.currentIndex;
      emit(SetNavIndexComplete(state.isButtonNavigatorShow, state.currentIndex,
          state.isSuggestionpageShown));
    });
    on<SetIsSuggestionPageShown>((event, emit) {
      state.isSuggestionpageShown = event.isSuggestionpageShown;
      emit(ButtonNavigator(state.isButtonNavigatorShow, state.currentIndex,
          event.isSuggestionpageShown));
      emit(SetCompleted(state.isButtonNavigatorShow, state.currentIndex,
          event.isSuggestionpageShown));
    });
  }
}
