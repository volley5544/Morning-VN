part of 'map_search_bloc.dart';

abstract class MapSearchState extends Equatable {
  late List<BranchDetail> branchOptions = <BranchDetail>[];
  late BranchDetail? currentBranch;
  late List<String> historyInputList = [];
  late bool shouldShowSuggestionPage = false;
  late bool isShowBrnachList = false;
  late String latestSearch;
  Position? deviceLocation;
  MapSearchState(
      {required this.branchOptions,
      this.currentBranch,
      required this.historyInputList,
      required this.shouldShowSuggestionPage,
      required this.isShowBrnachList,
      required this.latestSearch,
      this.deviceLocation});

  @override
  List<Object> get props => [];
}

class MapSearchInitial extends MapSearchState {
  MapSearchInitial(
      {required super.branchOptions,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchLoading extends MapSearchState {
  MapSearchLoading(
      {required super.branchOptions,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchComplete extends MapSearchState {
  MapSearchComplete(
      {required super.branchOptions,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchEmpty extends MapSearchState {
  MapSearchEmpty(
      {required super.branchOptions,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchError extends MapSearchState {
  MapSearchError(
      {required super.branchOptions,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapInfoBoxInitial extends MapSearchState {
  MapInfoBoxInitial(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapInfoBoxLoading extends MapSearchState {
  MapInfoBoxLoading(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapInfoBoxComplete extends MapSearchState {
  MapInfoBoxComplete(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapInfoBoxError extends MapSearchState {
  MapInfoBoxError(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchNearbyInitial extends MapSearchState {
  MapSearchNearbyInitial(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchNearbyLoading extends MapSearchState {
  MapSearchNearbyLoading(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchNearbyComplete extends MapSearchState {
  MapSearchNearbyComplete(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSearchNearbyError extends MapSearchState {
  MapSearchNearbyError(
      {required super.branchOptions,
      super.currentBranch,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}

class MapSetSearchHistory extends MapSearchState {
  MapSetSearchHistory(
      {required super.branchOptions,
      required super.historyInputList,
      required super.shouldShowSuggestionPage,
      required super.isShowBrnachList,
      required super.latestSearch});
}
