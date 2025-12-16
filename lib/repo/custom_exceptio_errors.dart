String customAuthException(dynamic e) {
  if (e.code.contains('user-not-found')) {
    throw 'No user found for that email.';
  } else if (e.code.contains('wrong-password')) {
    throw 'Wrong password!';
  } else if (e.code.contains('invalid-email')) {
    throw 'Invalid email provided or no account exists with this email.';
  } else if (e.code.contains('user-disabled')) {
    throw ' This account is disabled. Contact your administrator.';
  } else if (e.code.contains('too-many-requests')) {
    throw 'Too many requests for this account.';
  } else if (e.code.contains('email-already-in-use')) {
    throw 'Email already in use.';
  } else if (e.code.contains('weak-password')) {
    throw 'Password is too weak.';
  } else {
    throw 'Invalid credentials provided, please try again later!';
  }
}

String customFirestoreException(String e) {
  if (e.contains('not-found')) {
    return 'Document or data not found.';
  } else if (e.contains('permission-denied') ||
      e.contains('have permissions')) {
    return 'You don\'t have permissions to access this data.';
  } else if (e.contains('unavailable')) {
    return 'Service is currently unavailable. Try again later.';
  } else if (e.contains('cancelled')) {
    return 'Operation was cancelled.';
  } else if (e.contains('invalid-argument')) {
    return 'Invalid arguments provided. Please try again later.';
  } else if (e.contains('deadline-exceeded')) {
    return 'Operation took too long to complete. Check your network connection.';
  } else {
    return 'Check your internet connection. Please try again later.';
  }
}
