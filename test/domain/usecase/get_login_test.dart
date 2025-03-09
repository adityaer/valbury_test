import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:valbury_test/data/model/response/profile_model.dart';
import 'package:valbury_test/domain/usecase/remote/get_login.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetLogin usecase;
  late MockAppRepository mockrepository;

  setUp(() {
    mockrepository = MockAppRepository();
    usecase = GetLogin(mockrepository);
  });

  final tProfile = ProfileModel();

  test('should get profile object from the repository', () async {
    // arrange
    when(
      mockrepository.login('',''),
    ).thenAnswer((_) async => Right(tProfile));
    // act
    final result = await usecase.execute('','');
    // assert
    expect(result, Right(tProfile));
  });
}
