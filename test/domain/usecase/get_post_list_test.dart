import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/domain/usecase/remote/get_mypost_list.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetMyPostList usecase;
  late MockAppRepository mockrepository;

  setUp(() {
    mockrepository = MockAppRepository();
    usecase = GetMyPostList(mockrepository);
  });

  final tPostList = <Post>[];

  test('should get list of post object from the repository', () async {
    // arrange
    when(
      mockrepository.getMyPostList(1),
    ).thenAnswer((_) async => Right(tPostList));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tPostList));
  });
}
