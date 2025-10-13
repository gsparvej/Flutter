class ProductionSummary {
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

  ProductionSummary(
      {this.shortSTotal,
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
        this.remainingFullXLQty});

  ProductionSummary.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shortSTotal'] = this.shortSTotal;
    data['shortMTotal'] = this.shortMTotal;
    data['shortLTotal'] = this.shortLTotal;
    data['shortXLTotal'] = this.shortXLTotal;
    data['fullSTotal'] = this.fullSTotal;
    data['fullMTotal'] = this.fullMTotal;
    data['fullLTotal'] = this.fullLTotal;
    data['fullXLTotal'] = this.fullXLTotal;
    data['remainingShortSQty'] = this.remainingShortSQty;
    data['remainingShortMQty'] = this.remainingShortMQty;
    data['remainingShortLQty'] = this.remainingShortLQty;
    data['remainingShortXLQty'] = this.remainingShortXLQty;
    data['remainingFullSQty'] = this.remainingFullSQty;
    data['remainingFullMQty'] = this.remainingFullMQty;
    data['remainingFullLQty'] = this.remainingFullLQty;
    data['remainingFullXLQty'] = this.remainingFullXLQty;
    return data;
  }
}
