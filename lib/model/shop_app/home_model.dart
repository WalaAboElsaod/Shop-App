class HomeModel {
     bool? status;
   HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  // banners=[];
  late List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      // banners.add(element);
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      // banners.add(element);
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
   int? id;
   String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class ProductModel {
  late int id;
   dynamic price;
   dynamic oldprice;
   dynamic discount;
     String? image;
     String? name;
    late bool infavorite;
      bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
