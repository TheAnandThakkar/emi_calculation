import 'package:emi_calculation/model/emi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenController extends GetxController {
  var selectedTenureIndex = 0.obs;

  EmiModel? emiModel;

  var loanAmountController = TextEditingController();

  /// loan amount
  var currentLoanAmount = 1000.00.obs;
  var loanAmountApi = 1000.obs;

  /// loan tenure
  var currentLoanTenure = 3.00.obs;
  var loanTenureApi = 3.obs;

  /// interest rate
  var currentInterestRate = 20.0.obs;
  var currentInterestRateApi = 20.obs;

  /// date list
  var dateList = <String>[].obs;
  RxnString selectedSalaryCycleDateDropdown = RxnString();
  RxnString selectedLoanDisbursementDateDropdown = RxnString();
  var currentMonth = ''.obs;
  var currentMonthNumber = ''.obs;
  var currentYear = ''.obs;
  var selectedSalaryCycleDateApi = ''.obs;
  var selectedLoanDisbursementDateApi = ''.obs;

  var interestList = <dynamic>[].obs; // Observable list to hold the EMI data

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // Function to format number in Indian currency format
    String formatIndianCurrency(int value) {
      final formatter = NumberFormat("#,##,##0"); // Indian Number Format
      return formatter.format(value);
    }

    loanAmountController.text = formatIndianCurrency(loanAmountApi.value);

    DateTime now = DateTime.now();
    // Format the date to display the month and year
    currentMonth.value = DateFormat('MMMM').format(now);
    currentMonthNumber.value = DateFormat('MM').format(now);
    currentYear.value = DateFormat('yyyy').format(now);

    List<String> getDateList() {
      DateTime now = DateTime.now();
      int daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

      return List.generate(daysInMonth, (index) {
        return (index + 1).toString(); // Return date as a string
      });
    }

    dateList.value = getDateList();
  }
}
