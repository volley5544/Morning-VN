import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

import '../../bloc/map_search_bloc/map_search_bloc.dart';
import '../../bloc/map_bloc/map_bloc.dart';
import '../../widgets/suggest_result.dart';

class SuggestionList extends StatefulWidget {
  final MapState mapState;
  final TextEditingController fieldSearchText;
  final Function setSelectedSuggestion;
  final Position position;
  const SuggestionList(
      {super.key,
      required this.mapState,
      required this.fieldSearchText,
      required this.setSelectedSuggestion,
      required this.position});

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...(widget.mapState.branchOptions.map((branch) => SuggetResult(
            widget.fieldSearchText.text,
            branch,
            widget.setSelectedSuggestion,
            widget.position))),
      ],
    );
  }
}
