import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:valbury_test/data/model/response/album_detail_model.dart';
import 'package:valbury_test/domain/usecase/remote/get_myalbumdetail_list.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetMyAlbumDetailList usecase;
  late MockAppRepository mockrepository;

  setUp(() {
    mockrepository = MockAppRepository();
    usecase = GetMyAlbumDetailList(mockrepository);
  });

  final tAlbumDetailList = <AlbumDetailModel>[];

  test('should get list of album detail object from the repository', () async {
    // arrange
    when(
      mockrepository.getMyAlbumDetailList(1),
    ).thenAnswer((_) async => Right(tAlbumDetailList));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tAlbumDetailList));
  });
}
