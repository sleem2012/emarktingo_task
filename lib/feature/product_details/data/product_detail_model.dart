class ProductDetailsModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? categoryId;
  String? image;
  String? length;
  String? width;
  String? height;
  String? weight;
  int? merchantId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ProductDetailsModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.categoryId,
        this.image,
        this.length,
        this.width,
        this.height,
        this.weight,
        this.merchantId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['category_id'];
    image = json['image'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    merchantId = json['merchant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

}
