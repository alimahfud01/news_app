import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article_entity.dart';

abstract class RemoteArticleState extends Equatable {}

class RemoteArticleOnLoading extends RemoteArticleState {
  RemoteArticleOnLoading();
  @override
  List<Object?> get props => [];
}

class RemoteArticleOnSuccess extends RemoteArticleState {
  final List<ArticleEntity> articles;

  RemoteArticleOnSuccess(this.articles);
  @override
  List<Object?> get props => [articles];
}

class RemoteArticleOnFailed extends RemoteArticleState {
  final DioError error;

  RemoteArticleOnFailed(this.error);

  @override
  List<Object?> get props => [error];
}
