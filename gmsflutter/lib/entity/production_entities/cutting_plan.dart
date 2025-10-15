class CuttingPlan {
  int? id;
  String? markerNo;
  double? fabricWidth;
  int? layCount;
  double? plannedPcs;
  double? fabricUsed;
  String? status;
  String? cuttingDate;
  double? actualPcs;
  double? markerEfficiency;
  double? fabricLength;
  int? markerCount;
  String? remarks;
  String? createdBy;
  String? description;
  int? markerOutput;
  int uomId;
  int productionOrderId;

  CuttingPlan({
    this.id,
    required this.markerNo,
    required this.fabricWidth,
    required this.layCount,
    required this.plannedPcs,
    required this.fabricUsed,
    required this.status,
    required this.cuttingDate,
    required this.actualPcs,
    required this.markerEfficiency,
    required this.fabricLength,
    required this.markerCount,
    required this.remarks,
    required this.createdBy,
    required this.description,
    required this.markerOutput,
    required this.uomId,
    required this.productionOrderId,
  });

  /// ✅ FROM JSON
  factory CuttingPlan.fromJson(Map<String, dynamic> json) {
    return CuttingPlan(
      id: json['id'] as int?,
      markerNo: json['markerNo'] as String? ?? '',
      fabricWidth: (json['fabricWidth'] as num?)?.toDouble() ?? 0.0,
      layCount: json['layCount'] as int? ?? 0,
      plannedPcs: (json['plannedPcs'] as num?)?.toDouble() ?? 0.0,
      fabricUsed: (json['fabricUsed'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      cuttingDate: json['cuttingDate'] as String? ?? '',
      actualPcs: (json['actualPcs'] as num?)?.toDouble() ?? 0.0,
      markerEfficiency: (json['markerEfficiency'] as num?)?.toDouble() ?? 0.0,
      fabricLength: (json['fabricLength'] as num?)?.toDouble() ?? 0.0,
      markerCount: json['markerCount'] as int? ?? 0,
      remarks: json['remarks'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      description: json['description'] as String? ?? '',
      markerOutput: json['markerOutput'] as int? ?? 0,
      uomId: json['uomId'] as int? ?? 0,
      productionOrderId: json['productionOrderId'] as int? ?? 0,
    );
  }

  /// ✅ TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'markerNo': markerNo,
      'fabricWidth': fabricWidth,
      'layCount': layCount,
      'plannedPcs': plannedPcs,
      'fabricUsed': fabricUsed,
      'status': status,
      'cuttingDate': cuttingDate,
      'actualPcs': actualPcs,
      'markerEfficiency': markerEfficiency,
      'fabricLength': fabricLength,
      'markerCount': markerCount,
      'remarks': remarks,
      'createdBy': createdBy,
      'description': description,
      'markerOutput': markerOutput,
      'uomId': uomId,
      'productionOrderId': productionOrderId,
    };
  }
}