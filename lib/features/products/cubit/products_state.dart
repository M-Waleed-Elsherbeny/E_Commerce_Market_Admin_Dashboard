part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class AddNewProductLoading extends ProductsState {}

final class AddNewProductSuccess extends ProductsState {}

final class AddNewProductError extends ProductsState {
  final String errorMessage;
  AddNewProductError(this.errorMessage);
}

final class GetProductsLoading extends ProductsState {}

final class GetProductsSuccess extends ProductsState {}

final class GetProductsError extends ProductsState {
  final String errorMessage;
  GetProductsError(this.errorMessage);
}

final class EditProductsLoading extends ProductsState {}

final class EditProductsSuccess extends ProductsState {}

final class EditProductsError extends ProductsState {
  final String errorMessage;
  EditProductsError(this.errorMessage);
}

final class DeleteProductsLoading extends ProductsState {}

final class DeleteProductsSuccess extends ProductsState {}

final class DeleteProductsError extends ProductsState {
  final String errorMessage;
  DeleteProductsError(this.errorMessage);
}

final class UploadImageLoading extends ProductsState {}

final class UploadImageSuccess extends ProductsState {}

final class UploadImageError extends ProductsState {
  final String errorMessage;
  UploadImageError(this.errorMessage);
}
