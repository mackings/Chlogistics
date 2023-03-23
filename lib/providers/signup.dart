import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final Firebase = FirebaseAuth.instance;



final auth = Provider((ref) {
  return Firebase;
});


