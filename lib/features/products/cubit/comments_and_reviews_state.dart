part of 'comments_and_reviews_cubit.dart';

abstract class CommentsAndReviewsState {}

final class CommentsAndReviewsInitial extends CommentsAndReviewsState {}

final class GetCommentsLoading extends CommentsAndReviewsState {}

final class GetCommentsSuccess extends CommentsAndReviewsState {}

final class GetCommentsError extends CommentsAndReviewsState {
  final String? errorMessage;
  GetCommentsError(this.errorMessage);
}
