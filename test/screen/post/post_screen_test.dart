import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/helper/helper_enum.dart';
import 'package:valbury_test/screen/post/post_notifier.dart';
import 'package:valbury_test/screen/post/post_screen.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockPostNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPostNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PostNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.statePostList).thenReturn(RequestState.loaded);
    when(mockNotifier.postList).thenReturn(<Post>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(Postscreen()));

    expect(listViewFinder, findsOneWidget);
  });
}
