
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/core/router/router.dart'; 

import 'package:todo_mvvm/domain/entities/item.dart';
import 'package:todo_mvvm/viewmodels/item_list_view_model.dart';
import 'package:uuid/uuid.dart';

class AddUpdateTodoScreen extends ConsumerWidget {
  final Item? item; // If `item` is null, we're adding a new item.

  const AddUpdateTodoScreen({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descriptionController =
        TextEditingController(text: item?.description ?? '');

    return Scaffold(
      appBar: AppBar(title: Text(item == null ? 'Add To-Do' : 'Update To-Do')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  final viewModel = ref.read(itemListViewModelProvider.notifier);

                  if (item == null) {
  // Generate a unique ID
  final newItem = Item(
    id: const Uuid().v4(), // Generate a unique ID using the uuid package
    title: title,
    description: description,
  );

  viewModel.addItem(newItem);
} else {
  // Update existing item
  final updatedItem = item!.copyWith(
    title: title,
    description: description,
  );
  viewModel.updateItem(updatedItem);
}

                 context.go("/main");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Title and description cannot be empty.')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}