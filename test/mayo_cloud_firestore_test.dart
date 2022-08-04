import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayo_cloud_firestore/mayo_cloud_firestore.dart';

import 'models/user.dart';

void main() {
  const user = User(
    '1',
    name: 'John Doe',
    username: 'jdoe',
    email: 'john@doe.com',
  );

  late FirebaseFirestore firestore;
  late FirestoreDataProvider dataProvider;

  group('$FirebaseFirestore', () {
    setUpAll(() async {
      firestore = FakeFirebaseFirestore();
      dataProvider = FirestoreDataProvider(firestore);
    });

    test('add', () async {
      final newUser =
          await dataProvider.add('users', user.toJson(), User.fromJson);

      expect(newUser.id, isNotNull);
      expect(newUser, const TypeMatcher<User>());
    });
    test('getById', () async {
      final newUser =
          await dataProvider.add('users', user.toJson(), User.fromJson);

      final getUser =
          await dataProvider.getById('users', newUser.id, User.fromJson);

      expect(getUser, const TypeMatcher<User>());
    });
    test('getById not found exception', () async {
      expect(
        () async => dataProvider.getById('users', user.id, User.fromJson),
        throwsA(
          isA<FirestoreFailure>(),
        ),
      );
    });
  });
}
