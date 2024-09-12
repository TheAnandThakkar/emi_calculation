class EmiModel {
  EmiModel({
    this.status,
    this.message,
    this.data,
  });

  EmiModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.tenure,
    this.basicPrincipalAmount,
    this.interestRate,
    this.totalDaysInEmi,
    this.totalDaysInYear,
    this.perDayPrincipal,
    this.perDayInterest,
    this.totalRepaybleAmount,
    this.effectivePrincipalAmountTotal,
    this.emiAmount,
    this.totalInterestPayable,
    this.emi,
  });

  Data.fromJson(dynamic json) {
    tenure = json['tenure'];
    basicPrincipalAmount = json['basic_principal_amount'];
    interestRate = json['interest_rate'];
    totalDaysInEmi = json['total_days_in_emi'];
    totalDaysInYear = json['total_days_in_year'];
    perDayPrincipal = json['per_day_principal'];
    perDayInterest = json['per_day_interest'];
    totalRepaybleAmount = json['total_repayble_amount'];
    effectivePrincipalAmountTotal = json['effective_principal_amount_total'];
    emiAmount = json['emi_amount'];
    totalInterestPayable = json['total_interest_payable'];
    if (json['emi'] != null) {
      emi = [];
      json['emi'].forEach((v) {
        emi?.add(Emi.fromJson(v));
      });
    }
  }
  int? tenure;
  int? basicPrincipalAmount;
  int? interestRate;
  int? totalDaysInEmi;
  int? totalDaysInYear;
  double? perDayPrincipal;
  double? perDayInterest;
  double? totalRepaybleAmount;
  int? effectivePrincipalAmountTotal;
  double? emiAmount;
  double? totalInterestPayable;
  List<Emi>? emi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tenure'] = tenure;
    map['basic_principal_amount'] = basicPrincipalAmount;
    map['interest_rate'] = interestRate;
    map['total_days_in_emi'] = totalDaysInEmi;
    map['total_days_in_year'] = totalDaysInYear;
    map['per_day_principal'] = perDayPrincipal;
    map['per_day_interest'] = perDayInterest;
    map['total_repayble_amount'] = totalRepaybleAmount;
    map['effective_principal_amount_total'] = effectivePrincipalAmountTotal;
    map['emi_amount'] = emiAmount;
    map['total_interest_payable'] = totalInterestPayable;
    if (emi != null) {
      map['emi'] = emi?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Emi {
  Emi({
    this.fromDate,
    this.toDate,
    this.strMonth,
    this.noOfDaysForInterestCalc,
    this.principalAmount,
    this.interestAmount,
    this.emi,
    this.effectivePrincipalAmount,
    this.balanceAmount,
  });

  Emi.fromJson(dynamic json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    strMonth = json['str_month'];
    noOfDaysForInterestCalc = json['no_of_days_for_interest_calc'];
    principalAmount = double.tryParse(json['principal_amount'].toString());
    interestAmount = double.tryParse(json['interest_amount'].toString());
    emi = double.tryParse(json['emi'].toString());
    effectivePrincipalAmount = double.tryParse(json['effective_principal_amount'].toString());
    balanceAmount = double.tryParse(json['balance_amount'].toString());
  }
  String? fromDate;
  String? toDate;
  String? strMonth;
  int? noOfDaysForInterestCalc;
  double? principalAmount;
  double? interestAmount;
  double? emi;
  double? effectivePrincipalAmount;
  double? balanceAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['str_month'] = strMonth;
    map['no_of_days_for_interest_calc'] = noOfDaysForInterestCalc;
    map['principal_amount'] = principalAmount;
    map['interest_amount'] = interestAmount;
    map['emi'] = emi;
    map['effective_principal_amount'] = effectivePrincipalAmount;
    map['balance_amount'] = double.tryParse(balanceAmount.toString());
    return map;
  }
}
