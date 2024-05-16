import 'dart:convert';
import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../json_reader.dart';

void main() {
  const tTvModel = TVSeriesModel(
    backdropPath: '/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
    genreIds: [18, 10749],
    id: 11216,
    originalName: 'The Shawshank Redemption',
    overview:
        'Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.',
    popularity: 161.431,
    posterPath: '/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg',
    firstAirDate: '1994-09-23',
    name: 'The Shawshank Redemption',
    voteAverage: 8.705,
    voteCount: 26158,
    originCountry: ['it'],
    originalLanguage: 'it',
  );
  const tTvResponseModel = TVSeriesResponse(tvList: <TVSeriesModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('dummy_data/tvseries/now_playing_tvseries.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg",
            "genre_ids": [18, 10749],
            "id": 11216,
            "original_language": "it",
            "origin_country": ["it"],
            "original_name": "The Shawshank Redemption",
            "overview":
                "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
            "popularity": 161.431,
            "poster_path": "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
            "first_air_date": "1994-09-23",
            "name": "The Shawshank Redemption",
            "vote_average": 8.705,
            "vote_count": 26158
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
