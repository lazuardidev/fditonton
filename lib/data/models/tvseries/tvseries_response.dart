import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> tvList;
  const TVSeriesResponse({required this.tvList});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesResponse(
        tvList: List<TVSeriesModel>.from(
          (json['results'] as List)
              .map((e) => TVSeriesModel.fromJson(e))
              .where((element) => element.posterPath != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvList];
}
