import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/account.dart';
import 'custom_exceptio_errors.dart';

class AccountRepo {
  final _collection = FirebaseFirestore.instance.collection('accounts');

  Stream<Account?> getAccountStream(String uid) async* {
    try {
      await for (final snapshot in _collection.doc(uid).snapshots()) {
        if (!snapshot.exists) {
          yield null;
          continue;
        }

        final data = snapshot.data();
        if (data == null) {
          yield null;
          continue;
        }

        try {
          yield Account.fromJson(data);
        } catch (e, st) {
          developer.log('Error parsing account for $uid: $e', stackTrace: st);
          throw FormatException('Failed to parse account data for $uid: $e');
        }
      }
    } on FirebaseException catch (e, st) {
      developer.log(
        'Firestore error while listening for account $uid: ${e.message}',
        stackTrace: st,
      );
      // Convert Firestore error codes/messages into friendly messages.
      final message = customFirestoreException(e.code);
      throw Exception(message);
    } catch (e, st) {
      developer.log(
        'Unexpected error while listening for account $uid: $e',
        stackTrace: st,
      );
      throw Exception(
        'Unexpected error while listening to account stream for $uid: $e',
      );
    }
  }

  Future<void> setAccount(Account account) async {
    try {
      await _collection.doc(account.id).set(account.toJson());
    } on FirebaseException catch (e, st) {
      developer.log(
        'Firestore error while setting account ${account.id}: ${e.message}',
        stackTrace: st,
      );
      final message = customFirestoreException(e.code);
      throw Exception(message);
    } catch (e, st) {
      developer.log(
        'Unexpected error while setting account ${account.id}: $e',
        stackTrace: st,
      );
      throw Exception(
        'Unexpected error while setting account ${account.id}: $e',
      );
    }
  }

  Future<void> updateAccount(Account account) async {
    try {
      await _collection.doc(account.id).update(account.toJson());
    } on FirebaseException catch (e, st) {
      developer.log(
        'Firestore error while updating account ${account.id}: ${e.message}',
        stackTrace: st,
      );
      final message = customFirestoreException(e.code);
      throw Exception(message);
    } catch (e, st) {
      developer.log(
        'Unexpected error while updating account ${account.id}: $e',
        stackTrace: st,
      );
      throw Exception(
        'Unexpected error while updating account ${account.id}: $e',
      );
    }
  }
}
