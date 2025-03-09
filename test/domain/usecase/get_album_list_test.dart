import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:valbury_test/domain/entity/album.dart';
import 'package:valbury_test/domain/usecase/remote/get_myalbum_list.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetMyAlbumList usecase;
  late MockAppRepository mockrepository;

  setUp(() {
    mockrepository = MockAppRepository();
    usecase = GetMyAlbumList(mockrepository);
  });

  final tAlbumList = <Album>[];

  test('should get list of album object from the repository', () async {
    // arrange
    when(
      mockrepository.getMyAlbumList(1),
    ).thenAnswer((_) async => Right(tAlbumList));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tAlbumList));
  });
}
