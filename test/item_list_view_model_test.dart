import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_mvvm/viewmodels/item_list_view_model.dart';
import 'package:todo_mvvm/domain/entities/item.dart';

import 'mocks.mocks.dart';

void main() {
  late MockItemRepository mockLocalRepository;
  late MockItemRepository mockRemoteRepository;
  late ProviderContainer container;
  setUp(() {
    mockLocalRepository = MockItemRepository();
    mockRemoteRepository = MockItemRepository();

    container = ProviderContainer(
      overrides: [
        localItemRepositoryProvider.overrideWithValue(mockLocalRepository),
        remoteItemRepositoryProvider.overrideWithValue(mockRemoteRepository),
      ],
    );
  });
  test('should fetch items successfully', () async {
    // Arrange
    final mockItems = [
      Item(id: '1', title: 'Task 1', description: 'Description 1'),
      Item(id: '2', title: 'Task 2', description: 'Description 2'),
    ];

    // Stub both local and remote repositories
    when(mockLocalRepository.fetchItems()).thenAnswer((_) async => mockItems);
    when(mockRemoteRepository.fetchItems()).thenAnswer((_) async => mockItems);

    final viewModel = container.read(itemListViewModelProvider.notifier);

    // Act
    final result = await viewModel.fetchItems();

    // Assert
    expect(result, mockItems); // Verify returned items match mock data
    expect(viewModel.state, AsyncData(mockItems)); // Verify state is updated
    verify(mockLocalRepository.fetchItems()).called(1); // Verify local call
    verify(mockRemoteRepository.fetchItems()).called(1); // Verify remote call
  });

  test(
      'should sync items from Firestore to local repository and fetch them locally',
      () async {
    // Arrange
    final remoteItems = [
      Item(
          id: '1', title: 'Remote Task 1', description: 'Remote Description 1'),
      Item(
          id: '2', title: 'Remote Task 2', description: 'Remote Description 2'),
    ];

    // Stub remote fetch
    when(mockRemoteRepository.fetchItems())
        .thenAnswer((_) async => remoteItems);

    // Stub local repository to accept additions and fetch data
    when(mockLocalRepository.addItem(any)).thenAnswer((_) async {});
    when(mockLocalRepository.fetchItems()).thenAnswer((_) async => remoteItems);

    final viewModel = container.read(itemListViewModelProvider.notifier);

    // Act
    await viewModel.build(); // Triggers the sync and fetch logic

    // Assert
    verify(mockRemoteRepository.fetchItems()).called(2);
    expect(viewModel.state, AsyncData(remoteItems)); // Ensure state is updated
  });
}
