import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mayo_cloud_firestore/src/api_result.dart';

/// Firebase error codes related with firestore .
enum FirestoreFailureCodes {
  /// firestoreUnknown code from firebase
  firestoreUnknown('firestore/unknown'),

  /// failedPrecondition code from firebase
  failedPrecondition('failed-precondition'),

  /// dataStale code from firebase
  dataStale('data-stale'),

  /// failure code from firebase
  failure('failure'),

  /// permissionDenied code from firebase
  permissionDenied('permission-denied'),

  /// disconnected code from firebase
  disconnected('disconnected'),

  /// expiredToken code from firebase
  expiredToken('expired-token'),

  /// invalidToken code from firebase
  invalidToken('invalid-token'),

  /// maxRetries code from firebase
  maxRetries('max-retries'),

  /// overriddenBySet code from firebase
  overriddenBySet('overridden-by-set'),

  /// unavailable code from firebase
  unavailable('unavailable'),

  /// networkError code from firebase
  networkError('network-error'),

  /// writeCancelled code from firebase
  writeCancelled('write-cancelled'),

  /// invalidType code from firebase
  invalidType('invalid-type'),

  // Custom codes
  /// documentNotFound code from firebase
  documentNotFound('document-not-found'),

  /// queryWithoutResults code from firebase
  queryWithoutResults('query-without-results');

  /// Cosntructor
  const FirestoreFailureCodes(this.code);

  /// Code param
  final String code;
}

/// Possible operators for where
enum WhereOperator {
  /// isEqualTo operator
  isEqualTo,

  /// isNotEqualTo operator
  isNotEqualTo,

  /// isLessThan operator
  isLessThan,

  /// isLessThanOrEqualTo operator
  isLessThanOrEqualTo,

  /// isGreaterThan operator
  isGreaterThan,

  /// isGreaterThanOrEqualTo operator
  isGreaterThanOrEqualTo,

  /// arrayContains operator
  arrayContains,

  /// arrayContainsAny operator
  arrayContainsAny,

  /// whereIn operator
  whereIn,

  /// whereNotIn operator
  whereNotIn,

  /// isNull operator
  isNull,
}

/// Wrapper of where clause
class WhereItem {
  /// Constructor
  WhereItem(this.field, this.value, this.operator);

  /// Field name
  final String field;

  /// Value
  final dynamic value;

  /// Operator
  final WhereOperator operator;
}

/// Wrapper of order by clause
class OrderByItem {
  /// Constructor descending option
  OrderByItem.descending(this.field) : descending = true;

  /// Constructor ascending option
  OrderByItem.ascending(this.field) : descending = false;

  /// Field name
  final String field;

  /// Descending
  final bool descending;
}

/// {@template storage_failure}
/// Thrown if during the firestore operations a failure occurs.
/// {@endtemplate}
class FirestoreFailure implements Exception {
  /// {@macro storage_failure}
  const FirestoreFailure([
    this.code = 'unknown',
    this.message = 'An unknown exception occurred.',
    this.path,
    this.stackTrace,
  ]);

  /// Exception when a not found a document in firestore
  factory FirestoreFailure.documentNotFound(String path) {
    return FirestoreFailure(
      FirestoreFailureCodes.documentNotFound.code,
      'Document not found at $path',
      path,
    );
  }

  /// Exception when a query returns no results
  factory FirestoreFailure.queryWithoutResults(String path) {
    return FirestoreFailure(
      FirestoreFailureCodes.queryWithoutResults.code,
      'Where clause without results at $path',
      path,
    );
  }

  /// Create a firebase storage message
  /// from a firebase storage exception code.
  /// https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiHgOztuJ34AhWRwYUKHSLlBSEQFnoECCcQAQ&url=https%3A%2F%2Ffirebase.flutter.dev%2Fdocs%2Fauth%2Ferror-handling%2F&usg=AOvVaw0ogGX6sFtirrrutjo3euS5
  factory FirestoreFailure.fromCode(
    String code, {
    String? path,
    String? stackTrace,
  }) {
    if (code == FirestoreFailureCodes.firestoreUnknown.code) {
      return FirestoreFailure(
        code,
        'An unknown error occurred.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.failedPrecondition.code) {
      return FirestoreFailure(code, stackTrace!, path, stackTrace);
    } else if (code == FirestoreFailureCodes.dataStale.code) {
      return FirestoreFailure(
        code,
        'The transaction needs to be run again with current data.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.failure.code) {
      return FirestoreFailure(
        code,
        'The server indicated that this operation failed.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.permissionDenied.code) {
      return FirestoreFailure(
        code,
        "Client doesn't have permission to access the desired data.",
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.disconnected.code) {
      return FirestoreFailure(
        code,
        'The operation had to be aborted due to a network disconnect.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.expiredToken.code) {
      return FirestoreFailure(
        code,
        'The supplied auth token has expired.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.invalidToken.code) {
      return FirestoreFailure(
        code,
        'The supplied auth token was invalid.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.maxRetries.code) {
      return FirestoreFailure(
        code,
        'The transaction had too many retries.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.overriddenBySet.code) {
      return FirestoreFailure(
        code,
        'The transaction was overridden by a subsequent set.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.unavailable.code) {
      return FirestoreFailure(
        code,
        'The service is unavailable.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.networkError.code) {
      return FirestoreFailure(
        code,
        'The operation could not be performed due to a network error.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.writeCancelled.code) {
      return FirestoreFailure(
        code,
        'The write was canceled by the user.',
        path,
        stackTrace,
      );
    } else if (code == FirestoreFailureCodes.invalidType.code) {
      return FirestoreFailure(
        code,
        'Wrong model type. Must implement equatable',
        path,
        stackTrace,
      );
    } else {
      return const FirestoreFailure();
    }
  }

  /// The associated code.
  final String code;

  /// The associated error message.
  final String message;

  /// Exception stack trace
  final String? stackTrace;

  /// Accesing path
  final String? path;
}

/// Wrapeer to make CRUD operations in firestore
class FirestoreDataProvider {
  /// Constructor
  FirestoreDataProvider(this.instance);

  /// Firestore instance
  final FirebaseFirestore instance;

  Map<String, dynamic> _toMap(Map<String, dynamic>? data, String id) =>
      {...data ?? {}, 'id': id};

  Query<Map<String, dynamic>> _applyFilters(
    CollectionReference<Map<String, dynamic>> reference,
    List<WhereItem> whereItems,
  ) {
    Query<Map<String, dynamic>> query = reference;
    // Add where clauses
    for (final item in whereItems) {
      switch (item.operator) {
        case WhereOperator.isEqualTo:
          query = query.where(item.field, isEqualTo: item.value);
          break;
        case WhereOperator.isNotEqualTo:
          query = query.where(item.field, isNotEqualTo: item.value);
          break;
        case WhereOperator.isLessThan:
          query = query.where(item.field, isLessThan: item.value);
          break;
        case WhereOperator.isLessThanOrEqualTo:
          query = query.where(item.field, isLessThanOrEqualTo: item.value);
          break;
        case WhereOperator.isGreaterThan:
          query = query.where(item.field, isGreaterThan: item.value);
          break;
        case WhereOperator.isGreaterThanOrEqualTo:
          query = query.where(item.field, isGreaterThanOrEqualTo: item.value);
          break;
        case WhereOperator.arrayContains:
          query = query.where(item.field, arrayContains: item.value);
          break;
        case WhereOperator.arrayContainsAny:
          query = query.where(item.field, arrayContainsAny: item.value as List);
          break;
        case WhereOperator.whereIn:
          query = query.where(item.field, whereIn: item.value as List);
          break;
        case WhereOperator.whereNotIn:
          query = query.where(item.field, whereNotIn: item.value as List);
          break;
        case WhereOperator.isNull:
          query = query.where(item.field, isNull: true);
          break;
      }
    }
    return query;
  }

  Query<Map<String, dynamic>> _applyOrderBy(
    Query<Map<String, dynamic>> reference,
    List<OrderByItem> orderByItems,
  ) {
    var query = reference;
    // Add order by clauses
    for (final item in orderByItems) {
      query = query.orderBy(item.field, descending: item.descending);
    }
    return query;
  }

  /// Get a document from the database in the path [path]/[uid].
  ///
  /// Throws a [FirestoreFailure] if an error occurs.
  Future<T> getById<T>(
    String path,
    String uid,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final reference = instance.collection(path).doc(uid);
    try {
      final doc = await reference.get();

      // If doc doesn't exist, return DocumentNotFound
      if (!doc.exists) {
        throw FirestoreFailure.documentNotFound(reference.path);
      }

      return ApiResult.fromResponse(_toMap(doc.data(), doc.id), fromJson);
    } on FirestoreFailure {
      rethrow;
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Fetch all documents from the database in the path [path].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<List<T>> fetchAll<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final reference = instance.collection(path);

    try {
      return reference.get().then(
            (query) => query.docs
                .map(
                  (doc) => ApiResult.fromResponse(
                    _toMap(doc.data(), doc.id),
                    fromJson,
                  ),
                )
                .toList(),
          );
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Filter documents from [path] using the clauses in [whereItems].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<List<T>> where<T>(
    String path,
    List<WhereItem> whereItems,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final reference = instance.collection(path);

    try {
      final query = _applyFilters(reference, whereItems);
      final results = await query.get();

      if (results.docs.isEmpty) {
        throw FirestoreFailure.queryWithoutResults(path);
      }

      return results.docs
          .map(
            (doc) =>
                ApiResult.fromResponse(_toMap(doc.data(), doc.id), fromJson),
          )
          .toList();
    } on FirestoreFailure {
      rethrow;
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Filter documents from [path] using the clauses order by [orderBy].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<List<T>> orderBy<T>(
    String path,
    List<OrderByItem> orderByItems,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final reference = instance.collection(path);

    try {
      final query = _applyOrderBy(reference, orderByItems);
      final results = await query
          .orderBy(
            'field',
          )
          .get();

      if (results.docs.isEmpty) {
        throw FirestoreFailure.queryWithoutResults(path);
      }

      return results.docs
          .map(
            (doc) =>
                ApiResult.fromResponse(_toMap(doc.data(), doc.id), fromJson),
          )
          .toList();
    } on FirestoreFailure {
      rethrow;
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Filter documents from [path] using the clauses in [whereItems] and
  /// order by [orderBy].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<List<T>> whereAndOrderBy<T>(
    String path,
    List<WhereItem> whereItems,
    List<OrderByItem> orderByItems,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final reference = instance.collection(path);

    try {
      // TODO(miguel-mayo): Make this with Extension
      var query = _applyFilters(reference, whereItems);
      query = _applyOrderBy(query, orderByItems);
      final results = await query
          .orderBy(
            'field',
          )
          .get();

      if (results.docs.isEmpty) {
        throw FirestoreFailure.queryWithoutResults(path);
      }

      return results.docs
          .map(
            (doc) =>
                ApiResult.fromResponse(_toMap(doc.data(), doc.id), fromJson),
          )
          .toList();
    } on FirestoreFailure {
      rethrow;
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Update document in the path [path]/[uid] with the values in [data].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<void> update<T>(
    String path,
    String uid,
    Map<String, dynamic> data,
  ) async {
    final reference = instance.collection(path).doc(uid);

    try {
      return await reference.update(data);
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Set document in the path [path]/[uid] with the values in [data].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<void> set<T>(
    String path,
    String uid,
    Map<String, dynamic> data,
  ) async {
    final reference = instance.collection(path).doc(uid);

    try {
      return await reference.set(data);
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Add a document in [path] with the values on [data].
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<T> add<T>(
    String path,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final reference = instance.collection(path);

    try {
      final newDoc = await reference.add(data);
      return ApiResult.fromResponse(_toMap(data, newDoc.id), fromJson);
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Delete a document in [path]/[uid]
  ///
  /// [FirestoreFailure] if an error occurs.
  Future<void> delete<T>(
    String path,
    String uid,
  ) async {
    final reference = instance.collection(path).doc(uid);
    try {
      return await reference.delete();
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: reference.path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  /// Delete an entiere collection from [path].
  Future<void> deleteCollection<T>(
    String path,
  ) async {
    try {
      return await instance
          .collection(path)
          .get()
          .then((d) => d.docs.map((doc) => doc.reference.delete()));
    } on FirebaseException catch (err) {
      throw FirestoreFailure.fromCode(
        err.code,
        path: path,
        stackTrace: err.stackTrace.toString(),
      );
    } catch (_) {
      throw const FirestoreFailure();
    }
  }
}
