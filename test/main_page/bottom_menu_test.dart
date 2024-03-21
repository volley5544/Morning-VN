import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test buttonnavigationbar', (WidgetTester widgetTester) async {
    late int _selecteedIndex;
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
                backgroundColor: Colors.purple,
              ),
            ],
            onTap: (int index) {
              _selecteedIndex = index;
            },
          ),
        ),
      ),
    );
    await widgetTester.tap(find.text('Home'));
    expect(_selecteedIndex, 0);
    await widgetTester.tap(find.text('Business'));
    expect(_selecteedIndex, 1);
    await widgetTester.tap(find.text('School'));
    expect(_selecteedIndex, 2);
  });
}
