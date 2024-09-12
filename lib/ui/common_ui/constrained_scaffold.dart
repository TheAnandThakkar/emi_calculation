import 'package:flutter/material.dart';

class ConstrainedScaffold extends StatefulWidget {
  ConstrainedScaffold({
    Key? key,
    required this.child,
    this.appBar,
    this.backgroundColor,
    this.topSafeArea,
    this.bottomnSafeArea,
    this.extendBodyBehindAppbar,
  }) : super(key: key);
  List<Widget> child;
  AppBar? appBar;
  Color? backgroundColor;
  bool? topSafeArea;
  bool? bottomnSafeArea;
  bool? extendBodyBehindAppbar;

  @override
  State<ConstrainedScaffold> createState() => _ConstrainedScaffoldState();
}

class _ConstrainedScaffoldState extends State<ConstrainedScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: widget.extendBodyBehindAppbar ?? false,
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      body: SafeArea(
        top: widget.topSafeArea ?? true,
        bottom: widget.bottomnSafeArea ?? true,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              // reverse: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
