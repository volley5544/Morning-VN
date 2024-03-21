// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart';
// import 'package:mobile_application_srisawad/pages/map/serach_page.dart';

// void main() {
//   final mapSearchBloc =
//       BlocProvider<MapSearchBloc>(create: (context) => MapSearchBloc());
//   testWidgets('Test Search bar widgets', (WidgetTester widgetTester) async {
//     await widgetTester.pumpWidget(MultiBlocProvider(
//       providers: [mapSearchBloc],
//       child: MaterialApp(
//         home: Scaffold(
//             body: Stack(children: [
//           Column(
//             children: <Widget>[SearchPage()],
//           )
//         ])),
//       ),
//     ));

//     expect(find.byType(TextField), findsOneWidget);
//   });
// }
