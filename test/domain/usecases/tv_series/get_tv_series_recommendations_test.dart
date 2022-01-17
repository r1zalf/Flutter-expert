import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tv = <TvSeries>[];

  test('should get list of tv recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tv));
  });
}
