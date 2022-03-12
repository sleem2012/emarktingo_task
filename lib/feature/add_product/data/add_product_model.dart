class AddProductModel {
  String? name;
  String? description;
  String? categoryId;
  String? price;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? merchantId;
  String? image;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddProductModel(
      {this.name,
        this.description,
        this.categoryId,
        this.price,
        this.length,
        this.width,
        this.height,
        this.weight,
        this.merchantId,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.id});

  AddProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    categoryId = json['category_id'];
    price = json['price'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    merchantId = json['merchant_id'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['price'] = this.price;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['merchant_id'] = this.merchantId;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
