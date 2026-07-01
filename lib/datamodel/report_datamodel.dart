class ReportDatamodel {
  bool? status;
  List<Orders>? orders;
  int? totalOrderValue;
  int? totalRevenue;
  String? message;

  ReportDatamodel(
      {this.status,
      this.orders,
      this.totalOrderValue,
      this.totalRevenue,
      this.message});

  ReportDatamodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    totalOrderValue = json['total_order_value'];
    totalRevenue = json['total_revenue'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['total_order_value'] = this.totalOrderValue;
    data['total_revenue'] = this.totalRevenue;
    data['message'] = this.message;
    return data;
  }
}

class Orders {
  int? orderId;
  String? orderNo;
  String? orderValue;
  int? dacCode;
  String? pickupDeliveryAgentName;
  String? pickupDeliveryAgentMobile;
  String? dropoffDeliveryAgentName;
  String? dropoffDeliveryAgentMobile;
  String? pickupDate;
  String? pickupTime;
  String? dropoffDate;
  String? dropoffTime;
  String? customerName;
  int? customerId;
  String? customerPhone;
  String? addressLine1;
  String? addressLine2;
  String? landmark;
  String? pincode;
  String? actualPickupTime;
  String? actualDropoffTime;
  String? deliveredTime;
  String? note;
  List<OrderItems>? orderItems;
  int? orderTotalAmount;
  List<OrderImages>? orderImages;
  StoreKeeper? storeKeeper;
  String? modeOfPayment;

  Orders(
      {this.orderId,
      this.orderNo,
      this.orderValue,
      this.dacCode,
      this.pickupDeliveryAgentName,
      this.pickupDeliveryAgentMobile,
      this.dropoffDeliveryAgentName,
      this.dropoffDeliveryAgentMobile,
      this.pickupDate,
      this.pickupTime,
      this.dropoffDate,
      this.dropoffTime,
      this.customerName,
      this.customerId,
      this.customerPhone,
      this.addressLine1,
      this.addressLine2,
      this.landmark,
      this.pincode,
      this.actualPickupTime,
      this.actualDropoffTime,
      this.deliveredTime,
      this.note,
      this.orderItems,
      this.orderTotalAmount,
      this.orderImages,
      this.storeKeeper,
      this.modeOfPayment});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNo = json['order_no'];
    orderValue = json['order_value'];
    dacCode = json['dac_code'];
    pickupDeliveryAgentName = json['pickup_delivery_agent_name'];
    pickupDeliveryAgentMobile = json['pickup_delivery_agent_mobile'];
    dropoffDeliveryAgentName = json['dropoff_delivery_agent_name'];
    dropoffDeliveryAgentMobile = json['dropoff_delivery_agent_mobile'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    dropoffDate = json['dropoff_date'];
    dropoffTime = json['dropoff_time'];
    customerName = json['customer_name'];
    customerId = json['customer_id'];
    customerPhone = json['customer_phone'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    actualPickupTime = json['actual_pickup_time'];
    actualDropoffTime = json['actual_dropoff_time'];
    deliveredTime = json['delivered_time'];
    note = json['note'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    orderTotalAmount = json['order_total_amount'];
    if (json['order_images'] != null) {
      orderImages = <OrderImages>[];
      json['order_images'].forEach((v) {
        orderImages!.add(new OrderImages.fromJson(v));
      });
    }
    storeKeeper = json['store_keeper'] != null
        ? new StoreKeeper.fromJson(json['store_keeper'])
        : null;
    modeOfPayment = json['mode_of_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_no'] = this.orderNo;
    data['order_value'] = this.orderValue;
    data['dac_code'] = this.dacCode;
    data['pickup_delivery_agent_name'] = this.pickupDeliveryAgentName;
    data['pickup_delivery_agent_mobile'] = this.pickupDeliveryAgentMobile;
    data['dropoff_delivery_agent_name'] = this.dropoffDeliveryAgentName;
    data['dropoff_delivery_agent_mobile'] = this.dropoffDeliveryAgentMobile;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['dropoff_date'] = this.dropoffDate;
    data['dropoff_time'] = this.dropoffTime;
    data['customer_name'] = this.customerName;
    data['customer_id'] = this.customerId;
    data['customer_phone'] = this.customerPhone;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['landmark'] = this.landmark;
    data['pincode'] = this.pincode;
    data['actual_pickup_time'] = this.actualPickupTime;
    data['actual_dropoff_time'] = this.actualDropoffTime;
    data['delivered_time'] = this.deliveredTime;
    data['note'] = this.note;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['order_total_amount'] = this.orderTotalAmount;
    if (this.orderImages != null) {
      data['order_images'] = this.orderImages!.map((v) => v.toJson()).toList();
    }
    if (this.storeKeeper != null) {
      data['store_keeper'] = this.storeKeeper!.toJson();
    }
    data['mode_of_payment'] = this.modeOfPayment;
    return data;
  }
}

class OrderItems {
  int? id;
  Item? item;
  int? qty;
  String? unitPrice;
  String? subTotal;

  OrderItems({this.id, this.item, this.qty, this.unitPrice, this.subTotal});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    qty = json['qty'];
    unitPrice = json['unit_price'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['sub_total'] = this.subTotal;
    return data;
  }
}

class Item {
  int? itemPriceChartId;
  int? itemId;
  String? name;
  String? description;
  String? price;
  String? icon;
  int? serviceCategoryId;
  String? serviceCategoryName;
  int? storeKeeperId;
  String? serviceKeeperName;
  int? serviceId;
  String? serviceName;
  int? itemCategoryId;
  String? itemCategoryName;

  Item(
      {this.itemPriceChartId,
      this.itemId,
      this.name,
      this.description,
      this.price,
      this.icon,
      this.serviceCategoryId,
      this.serviceCategoryName,
      this.storeKeeperId,
      this.serviceKeeperName,
      this.serviceId,
      this.serviceName,
      this.itemCategoryId,
      this.itemCategoryName});

  Item.fromJson(Map<String, dynamic> json) {
    itemPriceChartId = json['item_price_chart_id'];
    itemId = json['item_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    icon = json['icon'];
    serviceCategoryId = json['service_category_id'];
    serviceCategoryName = json['service_category_name'];
    storeKeeperId = json['store_keeper_id'];
    serviceKeeperName = json['service_keeper_name'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    itemCategoryId = json['item_category_id'];
    itemCategoryName = json['item_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_price_chart_id'] = this.itemPriceChartId;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['icon'] = this.icon;
    data['service_category_id'] = this.serviceCategoryId;
    data['service_category_name'] = this.serviceCategoryName;
    data['store_keeper_id'] = this.storeKeeperId;
    data['service_keeper_name'] = this.serviceKeeperName;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['item_category_id'] = this.itemCategoryId;
    data['item_category_name'] = this.itemCategoryName;
    return data;
  }
}

class OrderImages {
  String? filePath;

  OrderImages({this.filePath});

  OrderImages.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}

class StoreKeeper {
  int? storeKeeperId;
  String? storekeeperName;
  String? storekeeperAddress;
  String? storekeeperPhone;
  String? storekeeperLatitude;
  String? storekeeperLongitude;

  StoreKeeper(
      {this.storeKeeperId,
      this.storekeeperName,
      this.storekeeperAddress,
      this.storekeeperPhone,
      this.storekeeperLatitude,
      this.storekeeperLongitude});

  StoreKeeper.fromJson(Map<String, dynamic> json) {
    storeKeeperId = json['store_keeper_id'];
    storekeeperName = json['storekeeper_name'];
    storekeeperAddress = json['storekeeper_Address'];
    storekeeperPhone = json['storekeeper_phone'];
    storekeeperLatitude = json['storekeeper_latitude'];
    storekeeperLongitude = json['storekeeper_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_keeper_id'] = this.storeKeeperId;
    data['storekeeper_name'] = this.storekeeperName;
    data['storekeeper_Address'] = this.storekeeperAddress;
    data['storekeeper_phone'] = this.storekeeperPhone;
    data['storekeeper_latitude'] = this.storekeeperLatitude;
    data['storekeeper_longitude'] = this.storekeeperLongitude;
    return data;
  }
}
