import 'package:flutter/material.dart';

enum View {
  FullView,
  OnlyCC,
  SingleDay,
}

FocusNode fullFocusNode;
FocusNode ccFocusNode;
FocusNode singleFocusNode;

const String fullViewRoute = "/fullView";

const String onlyCCRoute = "/onlyCC";

const String singleViewRoute = "/singleViewRoute";
