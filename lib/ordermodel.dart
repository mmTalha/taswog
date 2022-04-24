class Article {
  List<Data> datae  ;

  TotalInfo totalInfo;

  Article({this.datae, this.totalInfo});

  Article.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      datae = new List<Data>();
      json['data'].forEach((v) {
        datae.add(new Data.fromJson(v));
      });
    }
    totalInfo = json['total_info'] != null
        ? new TotalInfo.fromJson(json['total_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datae != null) {
      data['data'] = this.datae.map((v) => v.toJson()).toList();
    }
    if (this.totalInfo != null) {
      data['total_info'] = this.totalInfo.toJson();
    }
    return data;
  }
}

class Data {
  int saleId;
  String productId;
  int orderPaymentId;
  String salePrice;
  String saleQuantity;
  String discountAmount;
  String total;
  String salePaidStatus;
  int saleStatus;
  String createdAt;
  String updatedAt;
  int basicId;
  String productDate;
  String productName;
  String productQuantity;
  int discountId;
  int brandId;
  int subCategoryId;
  String productBarcode;
  String productSerialNo;
  String productUnits;
  String productDetails;
  int basicStatus;
  String productImage1;

  Data(
      {this.saleId,
        this.productId,
        this.orderPaymentId,
        this.salePrice,
        this.saleQuantity,
        this.discountAmount,
        this.total,
        this.salePaidStatus,
        this.saleStatus,
        this.createdAt,
        this.updatedAt,
        this.basicId,
        this.productDate,
        this.productName,
        this.productQuantity,
        this.discountId,
        this.brandId,
        this.subCategoryId,
        this.productBarcode,
        this.productSerialNo,
        this.productUnits,
        this.productDetails,
        this.basicStatus,
        this.productImage1});

  Data.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    productId = json['product_id'];
    orderPaymentId = json['order_payment_id'];
    salePrice = json['sale_price'];
    saleQuantity = json['sale_quantity'];
    discountAmount = json['discount_amount'];
    total = json['total'];
    salePaidStatus = json['sale_paid_status'];
    saleStatus = json['sale_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    basicId = json['basic_id'];
    productDate = json['product_date'];
    productName = json['product_name'];
    productQuantity = json['product_quantity'];
    discountId = json['discount_id'];
    brandId = json['brand_id'];
    subCategoryId = json['sub_category_id'];
    productBarcode = json['product_barcode'];
    productSerialNo = json['product_serial_no'];
    productUnits = json['product_units'];
    productDetails = json['product_details'];
    basicStatus = json['basic_status'];
    productImage1 = json['product_image1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['product_id'] = this.productId;
    data['order_payment_id'] = this.orderPaymentId;
    data['sale_price'] = this.salePrice;
    data['sale_quantity'] = this.saleQuantity;
    data['discount_amount'] = this.discountAmount;
    data['total'] = this.total;
    data['sale_paid_status'] = this.salePaidStatus;
    data['sale_status'] = this.saleStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['basic_id'] = this.basicId;
    data['product_date'] = this.productDate;
    data['product_name'] = this.productName;
    data['product_quantity'] = this.productQuantity;
    data['discount_id'] = this.discountId;
    data['brand_id'] = this.brandId;
    data['sub_category_id'] = this.subCategoryId;
    data['product_barcode'] = this.productBarcode;
    data['product_serial_no'] = this.productSerialNo;
    data['product_units'] = this.productUnits;
    data['product_details'] = this.productDetails;
    data['basic_status'] = this.basicStatus;
    data['product_image1'] = this.productImage1;
    return data;
  }
}

class TotalInfo {
  int orderPaymentId;
  String orderNo;
  String grandTotal;
  int itemCount;
  String customerName;
  int userId;
  String saleDate;
  String paymentStatus;
  String deliveryAddress;
  String number;
  int deliveryCharges;
  String orderTotal;
  String discount;
  String deliveryStatus;
  String createdAt;
  String updatedAt;

  TotalInfo(
      {this.orderPaymentId,
        this.orderNo,
        this.grandTotal,
        this.itemCount,
        this.customerName,
        this.userId,
        this.saleDate,
        this.paymentStatus,
        this.deliveryAddress,
        this.number,
        this.deliveryCharges,
        this.orderTotal,
        this.discount,
        this.deliveryStatus,
        this.createdAt,
        this.updatedAt});

  TotalInfo.fromJson(Map<String, dynamic> json) {
    orderPaymentId = json['order_payment_id'];
    orderNo = json['order_no'];
    grandTotal = json['grand_total'];
    itemCount = json['item_count'];
    customerName = json['customer_name'];
    userId = json['user_id'];
    saleDate = json['sale_date'];
    paymentStatus = json['payment_status'];
    deliveryAddress = json['delivery_address'];
    number = json['number'];
    deliveryCharges = json['delivery_charges'];
    orderTotal = json['order_total'];
    discount = json['discount'];
    deliveryStatus = json['delivery_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_payment_id'] = this.orderPaymentId;
    data['order_no'] = this.orderNo;
    data['grand_total'] = this.grandTotal;
    data['item_count'] = this.itemCount;
    data['customer_name'] = this.customerName;
    data['user_id'] = this.userId;
    data['sale_date'] = this.saleDate;
    data['payment_status'] = this.paymentStatus;
    data['delivery_address'] = this.deliveryAddress;
    data['number'] = this.number;
    data['delivery_charges'] = this.deliveryCharges;
    data['order_total'] = this.orderTotal;
    data['discount'] = this.discount;
    data['delivery_status'] = this.deliveryStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}