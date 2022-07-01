import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_dimy_tech/src/features/authentication/presentation/login_controller.dart';

import '../../../mocks.dart';

void main() {
  late MockFakeAuthRepository fakeAuthRepository;
  late LoginController loginController;

  setUp(() {
    fakeAuthRepository = MockFakeAuthRepository();
    loginController = LoginController(fakeAuthRepository: fakeAuthRepository);
  });

  group('LoginController', () {
    test("initial state is AsyncData", () {
      verifyNever(fakeAuthRepository.logout);
      expect(loginController.debugState, const AsyncData<void>(null));
    });

    test("Login with PIN", () async {
      when(() => fakeAuthRepository.login()).thenAnswer((_) => Future.value());
      expectLater(
        loginController.stream,
        emitsInOrder(
          [
            const AsyncLoading<void>(),
            const AsyncData<void>(null),
          ],
        ),
      );
      await loginController.login();
      verify(() => loginController.login()).called(1);
    });
  });
}
