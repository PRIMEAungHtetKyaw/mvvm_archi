
import 'package:flutter/material.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart'; 

import 'package:todo_mvvm/domain/entities/item.dart';
import 'package:todo_mvvm/viewmodels/item_list_view_model.dart';

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
                    // Add new item
                    viewModel.addItem(Item(
                      id: '', // Let Firestore generate the ID
                      title: title,
                      description: description,
                    ));
                  } else {
                    // Update existing item
                    viewModel.updateItem(item!.copyWith(
                      title: title,
                      description: description,
                    ));
                  }

                  Navigator.pop(context); // Go back to the main screen
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