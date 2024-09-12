import 'dart:convert';

import 'package:emi_calculation/model/emi_model.dart';
import 'package:emi_calculation/ui/common_ui/button_component.dart';
import 'package:emi_calculation/ui/common_ui/constrained_scaffold.dart';
import 'package:emi_calculation/ui/common_ui/unfocus_context.dart';
import 'package:emi_calculation/ui/home/home_screen_controller.dart';
import 'package:emi_calculation/utils/app_commons/app_colors.dart';
import 'package:emi_calculation/utils/app_commons/screen_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();

  // Function to format number in Indian currency format
  String formatIndianCurrency(int value) {
    final formatter = NumberFormat("#,##,##0"); // Indian Number Format
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => UnfocusedContext.unfocusedContext(context),
      child: ConstrainedScaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            'EMI Calculation - Instaclaus',
            style: TextStyle(
                // color: AppColors.whiteColor,
                // fontWeight: FontWeight.w700,
                // fontSize: 22.sp,
                ),
          ),
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         AppColors.indigo,
          //         AppColors.oceanBlue,
          //       ],
          //     ),
          //   ),
          // ),
          centerTitle: true,
        ),
        child: [
          Column(
            children: [
              loanAmountContainer(),
              tenureContainer(),
              interestRateContainer(),
              salaryCycleDateContainer(),
              loanDisbursementDateContainer(),
            ],
          ),
          submitButton(),
        ],
      ),
    );
  }

  Widget loanAmountContainer() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Loan Amount ( ₹ )',
                    style: TextStyle(
                      // color: AppColors.whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      // color: AppColors.whiteColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    controller: _homeScreenController.loanAmountController,
                    maxLines: 1,
                    cursorColor: AppColors.whiteColor,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int? newValue = int.tryParse(value.replaceAll(",", "")); // Remove commas before parsing
                      if (newValue != null && newValue >= 1000 && newValue <= 500000) {
                        _homeScreenController.currentLoanAmount.value = newValue.toDouble(); // Store as double for Slider
                        // Update TextField with formatted value
                        _homeScreenController.loanAmountController.text = formatIndianCurrency(newValue);
                        // Move cursor to end after formatting
                        _homeScreenController.loanAmountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _homeScreenController.loanAmountController.text.length),
                        );
                        _homeScreenController.loanAmountApi.value = newValue;
                      }
                    },
                  ),
                ),
              ],
            ),
            Slider(
              value: _homeScreenController.currentLoanAmount.value,
              min: 1000,
              max: 500000,
              divisions: 499,
              activeColor: AppColors.activeBlueColor,
              inactiveColor: AppColors.inactiveGreyColor,
              label: (_homeScreenController.currentLoanAmount.value).round().toString(),
              onChanged: (double value) {
                int intValue = value.round(); // Round to nearest integer
                // Store the rounded integer in loanAmountApi for API usage
                _homeScreenController.loanAmountApi.value = intValue;
                _homeScreenController.currentLoanAmount.value = intValue.toDouble(); // Store rounded value for Slider
                _homeScreenController.loanAmountController.text = formatIndianCurrency(intValue); // Update TextField with formatted value
                // print(_homeScreenController.currentLoanAmount.value);
                // print(_homeScreenController.loanAmountController.text);
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ 1,000',
                  // style: TextStyle(color: AppColors.whiteColor),
                ),
                Text(
                  '₹ 5,00,000',
                  // style: TextStyle(color: AppColors.whiteColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tenureContainer() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Select Loan Tenure',
                    style: TextStyle(
                      // color: AppColors.whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.right,
                    _homeScreenController.loanTenureApi.value.toString() + ' Months',
                    style: TextStyle(
                      // color: AppColors.whiteColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: _homeScreenController.currentLoanTenure.value,
              min: 3,
              max: 12,
              divisions: 3,
              activeColor: AppColors.activeBlueColor,
              inactiveColor: AppColors.inactiveGreyColor,
              label: (_homeScreenController.currentLoanTenure.value).round().toString(),
              onChanged: (double value) {
                int intValue = value.round(); // Round to nearest integer
                // Store the rounded integer in loanAmountApi for API usage
                _homeScreenController.loanTenureApi.value = intValue;
                _homeScreenController.currentLoanTenure.value = intValue.toDouble(); // Store rounded value for Slide
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '3 Months',
                  // style: TextStyle(color: AppColors.whiteColor),
                ),
                Text(
                  '12 Months',
                  // style: TextStyle(color: AppColors.whiteColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget interestRateContainer() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Select Interest Rate',
                    style: TextStyle(
                      // color: AppColors.whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.right,
                    _homeScreenController.currentInterestRateApi.value.toString() + ' %',
                    style: TextStyle(
                      // color: AppColors.whiteColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: _homeScreenController.currentInterestRate.value,
              min: 1,
              max: 40,
              divisions: 40,
              activeColor: AppColors.activeBlueColor,
              inactiveColor: AppColors.inactiveGreyColor,
              label: (_homeScreenController.currentInterestRate.value).round().toString(),
              onChanged: null,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 %',
                ),
                Text(
                  '40 %',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget salaryCycleDateContainer() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Salary Cycle Date',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      _homeScreenController.currentYear.value,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      _homeScreenController.currentMonth.value,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _homeScreenController.selectedSalaryCycleDateDropdown.value = null;
                  },
                  icon: Icon(FontAwesomeIcons.xmark, color: Colors.red),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.inactiveGreyColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      icon: const Icon(
                        FontAwesomeIcons.arrowDown,
                        color: AppColors.activeBlueColor,
                      ),
                      elevation: 0,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      dropdownColor: AppColors.inactiveGreyColor,
                      value: _homeScreenController.selectedSalaryCycleDateDropdown.value,
                      hint: Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      items: _homeScreenController.dateList.map((String date) {
                        return DropdownMenuItem<String>(
                          value: date,
                          alignment: Alignment.center,
                          child: Text(
                            date,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _homeScreenController.selectedSalaryCycleDateDropdown.value = newValue;
                        _homeScreenController.selectedSalaryCycleDateApi.value =
                            '${_homeScreenController.currentMonthNumber.value}/${_homeScreenController.selectedSalaryCycleDateDropdown.value}/${_homeScreenController.currentYear.value}';
                        print(_homeScreenController.selectedSalaryCycleDateApi.value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loanDisbursementDateContainer() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Loan Disbursement Date',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      _homeScreenController.currentYear.value,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      _homeScreenController.currentMonth.value,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _homeScreenController.selectedLoanDisbursementDateDropdown.value = null;
                  },
                  icon: Icon(FontAwesomeIcons.xmark, color: Colors.red),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.inactiveGreyColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      icon: const Icon(
                        FontAwesomeIcons.arrowDown,
                        color: AppColors.activeBlueColor,
                      ),
                      elevation: 0,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      dropdownColor: AppColors.inactiveGreyColor,
                      value: _homeScreenController.selectedLoanDisbursementDateDropdown.value,
                      hint: Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      items: _homeScreenController.dateList.map((String date) {
                        return DropdownMenuItem<String>(
                          value: date,
                          alignment: Alignment.center,
                          child: Text(
                            date,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _homeScreenController.selectedLoanDisbursementDateDropdown.value = newValue;
                        _homeScreenController.selectedLoanDisbursementDateApi.value =
                            '${_homeScreenController.currentMonthNumber.value}/${_homeScreenController.selectedLoanDisbursementDateDropdown.value}/${_homeScreenController.currentYear.value}';
                        print(_homeScreenController.selectedLoanDisbursementDateApi.value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      // margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: double.infinity,
      child: ButtonComponent.elevatedButton(
        primaryColor: AppColors.activeBlueColor,
        foregroundColor: AppColors.whiteColor,
        title: 'Calculate EMI',
        onPress: () async {
          AlertDialog alert = AlertDialog(
            backgroundColor: AppColors.transparentColor,
            elevation: 0.0,
            content: CupertinoActivityIndicator(),
          );
          var apiObj = {
            "basic_principal_amount": _homeScreenController.loanAmountApi.value,
            "tenure": _homeScreenController.loanTenureApi.value,
            // "rate": _homeScreenController.currentInterestRateApi.value,
            "salary_cycle_date": (_homeScreenController.selectedSalaryCycleDateApi.value).isNotEmpty ? _homeScreenController.selectedSalaryCycleDateApi.value : null,
            "loan_disbursement_date": (_homeScreenController.selectedLoanDisbursementDateApi.value).isNotEmpty ? _homeScreenController.selectedLoanDisbursementDateApi.value : null,
          };
          print(apiObj);

          if (_homeScreenController.selectedSalaryCycleDateDropdown.value == null) {
            const snackBar = SnackBar(
              content: Text('Salary cycle date should not be empty'),
              backgroundColor: Colors.red,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }

          if (_homeScreenController.selectedLoanDisbursementDateDropdown.value == null) {
            const snackBar = SnackBar(
              content: Text('Loan disbursement date should not be empty'),
              backgroundColor: Colors.red,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }

          final response = await http.post(
            Uri.parse('https://stag-api.instaclaus.com/admin/emiCalculation'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(apiObj),
          );

          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );

          _homeScreenController.emiModel = EmiModel.fromJson(jsonDecode(response.body));

          if (response.statusCode == 200) {
            Future.delayed(Duration(milliseconds: 1000), () {
              Get.back();
              Get.toNamed(ScreenRoutes.emiScreen);
            });
          }

          // print(apiObj);
          // print(response);
          // print('Status code: ${response.statusCode}');
          // print('Response body: ${response.body}');
        },
      ),
    );
  }
}
