import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_mvvm/domain/entities/item.dart';
import 'package:todo_mvvm/domain/entities/user.dart';
import 'package:todo_mvvm/domain/repositories/auth_repository.dart';
import 'package:todo_mvvm/domain/repositories/item_repository.dart';
import 'package:todo_mvvm/providers/auth_providers.dart';
import 'package:todo_mvvm/providers/item_providers.dart';
import 'package:todo_mvvm/providers/profile_providers.dart';
import 'mocks.mocks.dart';

@GenerateMocks([AuthRepository, ItemRepository])
void main() {
  late MockItemRepository mockLocalRepository;
  late MockItemRepository mockRemoteRepository;
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  setUp(() {
    mockLocalRepository = MockItemRepository();
    mockRemoteRepository = MockItemRepository();
    mockAuthRepository = MockAuthRepository();

    // Stub the getCurrentUser method for the mockAuthRepository
    when(mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async =>   User(email: 'test@example.com'));

    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        localItemRepositoryProvider.overrideWithValue(mockLocalRepository),
        remoteItemRepositoryProvider.overrideWithValue(mockRemoteRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('should fetch items successfully', () async {
    // Arrange
    final mockItems = [
      Item(id: '1', title: 'Task 1', description: 'Description 1'),
      Item(id: '2', title: 'Task 2', description: 'Description 2'),
    ];

    when(mockLocalRepository.fetchItems()).thenAnswer((_) async => mockItems);
    when(mockRemoteRepository.fetchItems()).thenAnswer((_) async => mockItems);

    final viewModel = container.read(itemListViewModelProvider.notifier);

    // Act
    await viewModel.build();

    // Assert
    expect(viewModel.state, AsyncData(mockItems)); 
    verify(mockRemoteRepository.fetchItems()).called(2);
  });

  
  test('should handle user logout and clear local items', () async {
    // Arrange
    when(mockAuthRepository.logout()).thenAnswer((_) async {});
    when(mockLocalRepository.clearItems()).thenAnswer((_) async {});

    final profileViewModel = container.read(profileViewModelProvider.notifier);

    // Act
    await profileViewModel.logout();

    // Assert
    verify(mockAuthRepository.logout()).called(1);
    verify(mockLocalRepository.clearItems()).called(1);
  });
}
