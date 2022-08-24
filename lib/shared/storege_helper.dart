import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStorageHelper {
static late SharedPreferences obj;
MyStorageHelper();
static Future<SharedPreferences> Storageiniate()async{
 obj =await SharedPreferences.getInstance();

  return obj;
}
}