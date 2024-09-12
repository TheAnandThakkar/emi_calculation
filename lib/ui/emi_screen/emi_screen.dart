import 'dart:ffi';

import 'package:emi_calculation/utils/app_commons/app_colors.dart';
import 'package:emi_calculation/utils/extensions/sized_box_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../home/home_screen_controller.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({super.key});

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();

  @override
  void initState() {
    print(_homeScreenController.emiModel?.toJson());
    _homeScreenController.interestList.value = _homeScreenController.emiModel!.data!.emi!
        .map(
          (e) => e.interestAmount, // Directly map the values
        )
        .toList(); // Convert the map to a list
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_homeScreenController.interestList);
    var totalIntPayable = _homeScreenController.emiModel?.data?.totalInterestPayable ?? 0.00;
    var totalPrincipalAmount = _homeScreenController.emiModel?.data?.basicPrincipalAmount ?? 0;
    var effectiveRateOfInt = ((totalIntPayable / totalPrincipalAmount) * 100).toStringAsFixed(2);
    var sortInterestList = _homeScreenController.interestList.sort();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("EMI Chart"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 160.h,
                child: PieChart(
                  swapAnimationDuration: Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                  PieChartData(sections: [
                    PieChartSectionData(
                      value: _homeScreenController.emiModel?.data?.interestRate?.toDouble() ?? 0,
                      color: CupertinoColors.activeGreen,
                      titleStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    PieChartSectionData(
                      value: double.parse(effectiveRateOfInt),
                      color: CupertinoColors.activeOrange,
                      radius: 50,
                      borderSide: BorderSide(
                        color: AppColors.blackColor,
                      ),
                      titleStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ], centerSpaceRadius: 40.r),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: CupertinoColors.activeOrange,
                              radius: 8,
                            ),
                            16.sizedBoxW,
                            Expanded(
                              child: Text(
                                'Effective rate of interest',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: CupertinoColors.activeGreen,
                              radius: 8,
                            ),
                            16.sizedBoxW,
                            Expanded(
                              child: Text(
                                'Actual rate of interest',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    Text(
                      '₹ ' + (_homeScreenController.emiModel?.data?.emiAmount ?? 0.00).toString(),
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('Total EMI payable'),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Basic principal amount',
                          ),
                        ),
                        Text(
                          '₹ ' + (_homeScreenController.emiModel?.data?.basicPrincipalAmount ?? 0).toString(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Loan start date',
                          ),
                        ),
                        Text('${_homeScreenController.selectedSalaryCycleDateDropdown.value} ${_homeScreenController.currentMonth.value} ${_homeScreenController.currentYear.value}'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total days in an EMI',
                          ),
                        ),
                        Text(
                          (_homeScreenController.emiModel?.data?.totalDaysInEmi ?? 0).toString(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total days in a year',
                          ),
                        ),
                        Text(
                          (_homeScreenController.emiModel?.data?.totalDaysInYear ?? 0).toString(),
                        ),
                      ],
                    ),
                    16.sizedBoxH,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Per day principal',
                          ),
                        ),
                        Text(
                          (_homeScreenController.emiModel?.data?.perDayPrincipal ?? 0).toString(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Per day interest',
                          ),
                        ),
                        Text(
                          (_homeScreenController.emiModel?.data?.perDayInterest ?? 0).toString(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total interest payable',
                          ),
                        ),
                        Text(
                          (_homeScreenController.emiModel?.data?.totalInterestPayable ?? 0).toString(),
                        ),
                      ],
                    ),
                    16.sizedBoxH,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total repayable amount',
                          ),
                        ),
                        Text(
                          '₹ ' + (_homeScreenController.emiModel?.data?.totalRepaybleAmount ?? 0).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.activeBlueColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Effective interest rate',
                          ),
                        ),
                        Text(
                          (effectiveRateOfInt).toString() + '%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.activeBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'EMI Schedule',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: CupertinoColors.activeOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  // height: 200.h,
                  child: Column(
                    children: [
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            barGroups: _homeScreenController.emiModel?.data?.emi?.map((emi) {
                              final index = _homeScreenController.emiModel?.data?.emi?.indexOf(emi);
                              return BarChartGroupData(
                                x: index ?? 0,
                                barRods: [
                                  BarChartRodData(
                                    color: AppColors.activeBlueColor,
                                    toY: emi.principalAmount ?? 0.00,
                                    width: 15,
                                    borderRadius: BorderRadius.circular(4.r),
                                    // backDrawRodData: BackgroundBarChartRodData(
                                    //   show: true,
                                    //   toY: 1000,
                                    //   color: AppColors.inactiveGreyColor,
                                    // ),
                                  ),
                                ],
                              );
                            }).toList(),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    final emi = _homeScreenController.emiModel?.data?.emi?[value.toInt()];
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 1, // Distance between the axis and the title
                                      child: Transform.rotate(
                                        angle: -1.5708, // 90 degrees in radians
                                        child: Text(emi?.principalAmount.toString() ?? ''),
                                      ),
                                    );
                                    return Text(emi?.principalAmount.toString() ?? '');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _homeScreenController.emiModel?.data?.emi?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            ('Installment #${index + 1}'),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: CupertinoColors.activeGreen,
                            ),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        16.sizedBoxH,
                        Row(
                          children: [
                            Expanded(
                              child: Text('EMI date'),
                            ),
                            Text(
                              _homeScreenController.emiModel?.data?.emi?[index].strMonth ?? '',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text('No of days for interest calculation'),
                            ),
                            Expanded(
                              child: Text(
                                (_homeScreenController.emiModel?.data?.emi?[index].noOfDaysForInterestCalc ?? 0.00).toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        16.sizedBoxH,
                        Row(
                          children: [
                            Expanded(
                              child: Text('Principal amount'),
                            ),
                            Expanded(
                              child: Text(
                                (_homeScreenController.emiModel?.data?.emi?[index].principalAmount ?? 0.00).toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Interest amount'),
                            ),
                            Expanded(
                              child: Text(
                                (_homeScreenController.emiModel?.data?.emi?[index].interestAmount ?? 0.00).toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text('EMI'),
                            ),
                            Expanded(
                              child: Text(
                                (_homeScreenController.emiModel?.data?.emi?[index].emi ?? 0.00).toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Balance'),
                            ),
                            Expanded(
                              child: Text(
                                (_homeScreenController.emiModel?.data?.emi?[index].balanceAmount ?? 0.00).toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
