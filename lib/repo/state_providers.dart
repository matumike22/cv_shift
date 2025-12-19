import 'package:cv_shift/repo/models/cv_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_repo.dart';
import 'cv_data_repo.dart';
import 'models/account.dart';

// StreamProvider for real-time updates
final authStateProvider = StreamProvider<User?>((ref) {
  final user = FirebaseAuth.instance.authStateChanges();
  return user;
});

final accountProvider = StreamProvider<Account?>((ref) {
  final authState = ref.watch(authStateProvider).value;
  if (authState == null) {
    return Stream.value(null);
  }
  final account = AccountRepo().getAccountStream(authState.uid);
  return account;
});

final recentCVsProvider = StreamProvider.autoDispose<List<CvData>>((ref) {
  final authState = ref.watch(authStateProvider).value;
  if (authState == null) {
    return Stream.value([]);
  }
  final cvDataStream = CvDataRepo().getCvDataStream(authState.uid);
  return cvDataStream;
});
