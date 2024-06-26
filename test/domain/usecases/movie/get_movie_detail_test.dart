import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailMovie usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetDetailMovie(mockMovieRepository);
  });

  const tId = 1;

  test('should get movie detail from repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testMovieDetail));
  });
}
