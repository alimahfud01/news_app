import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentasion/bloc/article/remote/remote_article_cubit.dart';

class RemoteArticleCubit extends Cubit<RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleCubit(this._getArticleUseCase) : super(RemoteArticleOnLoading());

  Future<void> get_article() async {
    emit(RemoteArticleOnLoading());
    try {
      final dataState = await _getArticleUseCase.call();

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(RemoteArticleOnSuccess(dataState.data!));
      }

      if (dataState is DataFailed) {
        emit(RemoteArticleOnFailed(dataState.error!));
      }
    } catch (e) {
      emit(RemoteArticleOnFailed(
          DioError(requestOptions: RequestOptions(path: e.toString()))));
    }
  }
}
