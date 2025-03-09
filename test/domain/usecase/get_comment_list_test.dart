import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:valbury_test/data/model/response/comment_model.dart';
import 'package:valbury_test/domain/entity/post.dart';
import 'package:valbury_test/domain/usecase/remote/get_mycommentpost_list.dart';
import 'package:valbury_test/domain/usecase/remote/get_mypost_list.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetMyCommentPostList usecase;
  late MockAppRepository mockrepository;

  setUp(() {
    mockrepository = MockAppRepository();
    usecase = GetMyCommentPostList(mockrepository);
  });

  final tCommentPostList = <CommentModel>[];

  test('should get list of comment post object from the repository', () async {
    // arrange
    when(
      mockrepository.getMyCommentPostList(1),
    ).thenAnswer((_) async => Right(tCommentPostList));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tCommentPostList));
  });
}
