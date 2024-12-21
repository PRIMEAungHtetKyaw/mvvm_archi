
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/core/theme/colors.dart';
import 'package:todo_mvvm/providers/item_providers.dart'; 

import '../../widgets/confirm_dialog.dart';

import 'dart:math'; 
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListViewModelProvider);

    // Function to generate random colors
    Color generateRandomColor() {
      final random = Random();
      return Color.fromARGB(
        255,
        random.nextInt(256), // Random value for red (0-255)
        random.nextInt(256), // Random value for green (0-255)
        random.nextInt(256), // Random value for blue (0-255)
      ).withOpacity(0.2); // Set slight transparency for softer colors
    }

    Future<void> refreshItems() async {
      // Trigger fetchItems in ViewModel to refresh the list
      await ref.read(itemListViewModelProvider.notifier).fetchItems();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Must Do List'),
        actions: [
          InkWell(
            onTap: () {
              context.push('/profile');
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: itemListState.when(
        data: (items) => RefreshIndicator(
          onRefresh: refreshItems,
         child: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 80, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 16),
                      Text(
                        'No items available.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Add First Item')
                    ],
                  ),
                )
              :
           ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final cardColor = generateRandomColor(); // Generate random color for each item

              return InkWell(
                onTap: () => context.push('/edit', extra: item),
                child: Card(
                  color: cardColor, // Apply random color to the card
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(item.description),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoConfirmDialog(
                                  title: """Are you sure want to delete "${item.title}"?""",
                                  message: "This action cannot be undone.",
                                  confirmButtonText: "Yes",
                                  cancelButtonText: "No",
                                  onConfirm: () {
                                    Navigator.pop(context); // Close the dialog
                                    ref.read(itemListViewModelProvider.notifier).deleteItem(item.id);
                                  },
                                  onCancel: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                );
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}