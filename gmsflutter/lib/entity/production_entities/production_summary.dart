class ProductionSummary {
  int? orderId; // added
  int? shortSTotal;
  int? shortMTotal;
  int? shortLTotal;
  int? shortXLTotal;
  int? fullSTotal;
  int? fullMTotal;
  int? fullLTotal;
  int? fullXLTotal;
  int? remainingShortSQty;
  int? remainingShortMQty;
  int? remainingShortLQty;
  int? remainingShortXLQty;
  int? remainingFullSQty;
  int? remainingFullMQty;
  int? remainingFullLQty;
  int? remainingFullXLQty;

  ProductionSummary({
    this.orderId,
    this.shortSTotal,
    this.shortMTotal,
    this.shortLTotal,
    this.shortXLTotal,
    this.fullSTotal,
    this.fullMTotal,
    this.fullLTotal,
    this.fullXLTotal,
    this.remainingShortSQty,
    this.remainingShortMQty,
    this.remainingShortLQty,
    this.remainingShortXLQty,
    this.remainingFullSQty,
    this.remainingFullMQty,
    this.remainingFullLQty,
    this.remainingFullXLQty,
  });

  ProductionSummary.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    shortSTotal = json['shortSTotal'];
    shortMTotal = json['shortMTotal'];
    shortLTotal = json['shortLTotal'];
    shortXLTotal = json['shortXLTotal'];
    fullSTotal = json['fullSTotal'];
    fullMTotal = json['fullMTotal'];
    fullLTotal = json['fullLTotal'];
    fullXLTotal = json['fullXLTotal'];
    remainingShortSQty = json['remainingShortSQty'];
    remainingShortMQty = json['remainingShortMQty'];
    remainingShortLQty = json['remainingShortLQty'];
    remainingShortXLQty = json['remainingShortXLQty'];
    remainingFullSQty = json['remainingFullSQty'];
    remainingFullMQty = json['remainingFullMQty'];
    remainingFullLQty = json['remainingFullLQty'];
    remainingFullXLQty = json['remainingFullXLQty'];
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'shortSTotal': shortSTotal,
      'shortMTotal': shortMTotal,
      'shortLTotal': shortLTotal,
      'shortXLTotal': shortXLTotal,
      'fullSTotal': fullSTotal,
      'fullMTotal': fullMTotal,
      'fullLTotal': fullLTotal,
      'fullXLTotal': fullXLTotal,
      'remainingShortSQty': remainingShortSQty,
      'remainingShortMQty': remainingShortMQty,
      'remainingShortLQty': remainingShortLQty,
      'remainingShortXLQty': remainingShortXLQty,
      'remainingFullSQty': remainingFullSQty,
      'remainingFullMQty': remainingFullMQty,
      'remainingFullLQty': remainingFullLQty,
      'remainingFullXLQty': remainingFullXLQty,
    };
  }
}
