part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  late List<BranchDetail> branchOptions = <BranchDetail>[];
  late List<BranchDetail> prevBranchList = <BranchDetail>[];
  late BranchDetail? currentBranch;
  late List<String> historyInputList = [];
  late bool shouldShowSuggestionPage = false;
  late bool isShowBrnachList;
  late String latestSearch;
  late int selectedIndex = 999;
  late String searchText;
  // const MapState();
  MapState(
      {required this.branchOptions,
      this.currentBranch,
      required this.historyInputList,
      required this.shouldShowSuggestionPage,
      required this.isShowBrnachList,
      required this.latestSearch,
      required this.selectedIndex,
      required this.searchText,
      required this.prevBranchList});
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {
  MapInitial(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch,
      required super.selectedIndex,
      required super.searchText,
      required super.prevBranchList});
}

class MapSearchLoading extends MapState {
  MapSearchLoading(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch,
      required super.selectedIndex,
      required super.searchText,
      required super.prevBranchList});
}

class MapComplete extends MapState {
  MapComplete(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch,
      required super.selectedIndex,
      required super.searchText,
      required super.prevBranchList});
}

class MapError extends MapState {
  MapError(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch,
      required super.selectedIndex,
      required super.searchText,
      required super.prevBranchList});
}

class MapNoresultFound extends MapState {
  MapNoresultFound(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch,
      required super.selectedIndex,
      required super.searchText,
      required super.prevBranchList});
}

class LoadOnTextChange extends MapState {
  LoadOnTextChange(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch,
      required super.selectedIndex,
      required super.searchText,
      required super.prevBranchList});
}
