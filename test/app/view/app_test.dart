import 'package:flutter_test/flutter_test.dart';
import 'package:rubiks_solver/app/app.dart';
import 'package:rubiks_solver/create_cube/create_cube.dart';

void main() {
  group('App', () {
    testWidgets('renders CreateCubePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CreateCubePage), findsOneWidget);
    });
  });
}
