
import 'package:admin_dashboard/core/database/database_constants.dart';

HomeProductsModel homeProductsModelFromJson(
  Map<String, dynamic> jsonResponse,
) => HomeProductsModel.fromJson(jsonResponse);

class HomeProductsModel {
  String? productId;
  String? createdAt;
  String? productName;
  String? productDescription;
  String? productOldPrice;
  String? productSale;
  String? productNewPrice;
  String? productImage;
  String? productCategory;
  List<FavoriteProductsTable>? favoriteProductsTable;
  List<SoldProducts>? soldProducts;
  List<UsersComments>? usersComments;

  HomeProductsModel({
    this.productId,
    this.createdAt,
    this.productName,
    this.productDescription,
    this.productOldPrice,
    this.productSale,
    this.productNewPrice,
    this.productImage,
    this.productCategory,
    this.favoriteProductsTable,
    this.soldProducts,
    this.usersComments,
  });

  HomeProductsModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    createdAt = json['created_at'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productOldPrice = json['product_old_price'];
    productSale = json['product_sale'];
    productNewPrice = json['product_new_price'];
    productImage = json['product_image'];
    productCategory = json['product_category'];

    if (json[FAVORITE_PRODUCTS_TABLE] != null) {
      favoriteProductsTable = <FavoriteProductsTable>[];
      json[FAVORITE_PRODUCTS_TABLE].forEach((v) {
        favoriteProductsTable!.add(FavoriteProductsTable.fromJson(v));
      });
    }

    if (json[SOLD_PRODUCTS_TABLE] != null) {
      soldProducts = <SoldProducts>[];
      json[SOLD_PRODUCTS_TABLE].forEach((v) {
        soldProducts!.add(SoldProducts.fromJson(v));
      });
    }

    if (json[COMMENTS_TABLE] != null) {
      usersComments = <UsersComments>[];
      json[COMMENTS_TABLE].forEach((v) {
        usersComments!.add(UsersComments.fromJson(v));
      });
    }
  }
}

class FavoriteProductsTable {
  String? id;
  Users? users;
  String? userId;
  String? createdAt;
  String? productId;
  bool? isFavorite;

  FavoriteProductsTable({
    this.id,
    this.users,
    this.userId,
    this.createdAt,
    this.productId,
    this.isFavorite,
  });

  FavoriteProductsTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    userId = json['user_id'];
    createdAt = json['created_at'];
    productId = json['product_id'];
    isFavorite = json['is_favorite'];
  }
}

class Users {
  String? name;
  String? email;
  String? userId;
  String? createdAt;

  Users({this.name, this.email, this.userId, this.createdAt});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userId = json['user_id'];
    createdAt = json['created_at'];
  }
}

class SoldProducts {
  String? id;
  bool? isSold;
  String? userId;
  String? createdAt;
  String? productId;

  SoldProducts({
    this.id,
    this.isSold,
    this.userId,
    this.createdAt,
    this.productId,
  });

  SoldProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSold = json['is_sold'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    productId = json['product_id'];
  }
}

UsersComments usersCommentsModelFromJson(
  Map<String, dynamic> jsonResponse,
) => UsersComments.fromJson(jsonResponse);
class UsersComments {
  String? createdAt;
  String? comment;
  String? userId;
  String? productId;
  String? id;
  String? replay;
  String? userName;

  UsersComments({
    this.createdAt,
    this.comment,
    this.userId,
    this.productId,
    this.id,
    this.replay,
    this.userName,
  });

  UsersComments.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    comment = json['comment'];
    userId = json['user_id'];
    productId = json['product_id'];
    id = json['id'];
    replay = json['replay'];
    userName = json['user_name'];
  }
}
