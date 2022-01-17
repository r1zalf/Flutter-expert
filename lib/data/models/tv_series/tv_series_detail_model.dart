import 'package:ditonton/data/models/genre/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

class TvSeriesDetailModel extends TvSeriesDetail {
  String? backdropPath;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<GenreModel>? genresmodel;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? status;
  String? tagline;
  String? type;
  int? voteAverage;
  int? voteCount;
  TvSeriesDetailModel({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genresmodel,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
    backdropPath: backdropPath,
    episodeRunTime: episodeRunTime,
    firstAirDate: firstAirDate,
    genres: genresmodel,
    homepage: homepage,
    id: id,
    inProduction: inProduction,
    languages: languages,
    lastAirDate: lastAirDate,
    name: name,
    numberOfEpisodes: numberOfEpisodes,
    numberOfSeasons: numberOfSeasons,
    originCountry: originCountry,
    originalLanguage: originalLanguage,
    originalName: originalName,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    status: status,
    tagline: tagline,
    type: type,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) => TvSeriesDetailModel(
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genresmodel: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: (json["vote_average"] as num).toInt(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genresmodel!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
