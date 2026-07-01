class GetcomplaintDatamodel {
  bool? status;
  List<Feedbacks>? feedbacks;
  String? message;

  GetcomplaintDatamodel({this.status, this.feedbacks, this.message});

  GetcomplaintDatamodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Feedbacks {
  int? id;
  int? orderId;
  int? orderItemId;
  int? agentId;
  int? shopkeeperId;
  String? description;
  String? createdAt;
  String? updatedAt;
  Order? order;
  OrderItem? orderItem;
  Agent? agent;
  Vendor? vendor;

  Feedbacks(
      {this.id,
      this.orderId,
      this.orderItemId,
      this.agentId,
      this.shopkeeperId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.order,
      this.orderItem,
      this.agent,
      this.vendor});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderItemId = json['order_item_id'];
    agentId = json['agent_id'];
    shopkeeperId = json['shopkeeper_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    orderItem = json['order_item'] != null
        ? new OrderItem.fromJson(json['order_item'])
        : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    vendor =
        json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['order_item_id'] = this.orderItemId;
    data['agent_id'] = this.agentId;
    data['shopkeeper_id'] = this.shopkeeperId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  String? orderNo;
  String? orderDate;
  int? deliveryCharge;
  int? reDeliveryCharge;
  int? orderStatus;
  int? dacCode;
  int? dropDacCode;
  int? storeKeeperId;
  String? orderValue;
  int? revenue;
  String? orderTaxValue;
  String? payableAmount;
  int? customerId;
  int? pickupStatus;
  int? pickupDeliveryAgentId;
  int? paymentStatus;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? pickupDate;
  int? pickupTime;
  int? pickupTimeslotId;
  String? modeOfPayment;
  int? dropoffStatus;
  String? dropoffDate;
  int? dropoffTime;
  int? dropoffTimeslotId;
  int? deliveryagentAssigned;
  String? deliveryPickupTime;
  String? customerCode;
  String? actualPickupTime;
  String? actualDropoffTime;
  String? completedTime;
  int? acceptedStatus;

  Order({
    this.id,
    this.orderNo,
    this.orderDate,
    this.deliveryCharge,
    this.reDeliveryCharge,
    this.orderStatus,
    this.dacCode,
    this.dropDacCode,
    this.storeKeeperId,
    this.orderValue,
    this.revenue,
    this.orderTaxValue,
    this.payableAmount,
    this.customerId,
    this.pickupStatus,
    this.pickupDeliveryAgentId,
    this.paymentStatus,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.pickupDate,
    this.pickupTime,
    this.pickupTimeslotId,
    this.modeOfPayment,
    this.dropoffStatus,
    this.dropoffDate,
    this.dropoffTime,
    this.dropoffTimeslotId,
    this.deliveryagentAssigned,
    this.deliveryPickupTime,
    this.customerCode,
    this.actualPickupTime,
    this.actualDropoffTime,
    this.completedTime,
    this.acceptedStatus,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    orderDate = json['order_date'];
    deliveryCharge = json['delivery_charge'];
    reDeliveryCharge = json['re_delivery_charge'];
    orderStatus = json['order_status'];
    dacCode = json['dac_code'];
    dropDacCode = json['drop_dac_code'];
    storeKeeperId = json['store_keeper_id'];
    orderValue = json['order_value'];
    revenue = json['revenue'];
    orderTaxValue = json['order_tax_value'];
    payableAmount = json['payable_amount'];
    customerId = json['customer_id'];
    pickupStatus = json['pickup_status'];
    pickupDeliveryAgentId = json['pickup_delivery_agent_id'];
    paymentStatus = json['payment_status'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    pickupTimeslotId = json['pickup_timeslot_id'];
    modeOfPayment = json['mode_of_payment'];
    dropoffStatus = json['dropoff_status'];
    dropoffDate = json['dropoff_date'];
    dropoffTime = json['dropoff_time'];
    dropoffTimeslotId = json['dropoff_timeslot_id'];
    deliveryagentAssigned = json['deliveryagent_assigned'];
    deliveryPickupTime = json['delivery_pickup_time'];
    customerCode = json['customer_code'];
    actualPickupTime = json['actual_pickup_time'];
    actualDropoffTime = json['actual_dropoff_time'];
    completedTime = json['completed_time'];
    acceptedStatus = json['accepted_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['order_date'] = this.orderDate;
    data['delivery_charge'] = this.deliveryCharge;
    data['re_delivery_charge'] = this.reDeliveryCharge;
    data['order_status'] = this.orderStatus;
    data['dac_code'] = this.dacCode;
    data['drop_dac_code'] = this.dropDacCode;
    data['store_keeper_id'] = this.storeKeeperId;
    data['order_value'] = this.orderValue;
    data['revenue'] = this.revenue;
    data['order_tax_value'] = this.orderTaxValue;
    data['payable_amount'] = this.payableAmount;
    data['customer_id'] = this.customerId;
    data['pickup_status'] = this.pickupStatus;
    data['pickup_delivery_agent_id'] = this.pickupDeliveryAgentId;
    data['payment_status'] = this.paymentStatus;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['pickup_timeslot_id'] = this.pickupTimeslotId;
    data['mode_of_payment'] = this.modeOfPayment;
    data['dropoff_status'] = this.dropoffStatus;
    data['dropoff_date'] = this.dropoffDate;
    data['dropoff_time'] = this.dropoffTime;
    data['dropoff_timeslot_id'] = this.dropoffTimeslotId;
    data['deliveryagent_assigned'] = this.deliveryagentAssigned;
    data['delivery_pickup_time'] = this.deliveryPickupTime;
    data['customer_code'] = this.customerCode;
    data['actual_pickup_time'] = this.actualPickupTime;
    data['actual_dropoff_time'] = this.actualDropoffTime;
    data['completed_time'] = this.completedTime;
    data['accepted_status'] = this.acceptedStatus;

    return data;
  }
}

class OrderItem {
  int? id;
  int? serviceCategoryId;
  int? storeKeeperId;
  int? serviceId;
  int? itemCategoryId;
  int? itemId;
  String? price;
  int? isActive;

  Item? item;

  OrderItem(
      {this.id,
      this.serviceCategoryId,
      this.storeKeeperId,
      this.serviceId,
      this.itemCategoryId,
      this.itemId,
      this.price,
      this.isActive,
      this.item});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceCategoryId = json['service_category_id'];
    storeKeeperId = json['store_keeper_id'];
    serviceId = json['service_id'];
    itemCategoryId = json['item_category_id'];
    itemId = json['item_id'];
    price = json['price'];
    isActive = json['is_active'];

    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_category_id'] = this.serviceCategoryId;
    data['store_keeper_id'] = this.storeKeeperId;
    data['service_id'] = this.serviceId;
    data['item_category_id'] = this.itemCategoryId;
    data['item_id'] = this.itemId;
    data['price'] = this.price;
    data['is_active'] = this.isActive;

    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? name;
  String? description;
  String? icon;
  int? isActive;

  Item({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.isActive,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['is_active'] = this.isActive;

    return data;
  }
}

class Agent {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? gender;
  int? isLogin;
  int? isActive;

  String? password;

  Agent({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.gender,
    this.isLogin,
    this.isActive,
    this.password,
  });

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    isLogin = json['is_login'];
    isActive = json['is_active'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['is_login'] = this.isLogin;
    data['is_active'] = this.isActive;
    data['password'] = this.password;

    return data;
  }
}

class Vendor {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? email;
  int? isLogin;
  int? isActive;
  int? serviceCategoryId;
  String? mobileVerifiedAt;
  String? emailVerifiedAt;
  String? password;
  String? lattittude;
  String? longitude;
  String? description;

  String? createdAt;
  String? updatedAt;

  Vendor(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.email,
      this.isLogin,
      this.isActive,
      this.serviceCategoryId,
      this.mobileVerifiedAt,
      this.emailVerifiedAt,
      this.password,
      this.lattittude,
      this.longitude,
      this.description,
      this.createdAt,
      this.updatedAt});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['Address'];
    email = json['email'];
    isLogin = json['is_login'];
    isActive = json['is_active'];
    serviceCategoryId = json['service_category_id'];
    mobileVerifiedAt = json['mobile_verified_at'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    lattittude = json['lattittude'];
    longitude = json['longitude'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['Address'] = this.address;
    data['email'] = this.email;
    data['is_login'] = this.isLogin;
    data['is_active'] = this.isActive;
    data['service_category_id'] = this.serviceCategoryId;
    data['mobile_verified_at'] = this.mobileVerifiedAt;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['lattittude'] = this.lattittude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
