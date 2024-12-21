
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart'; 

import 'package:todo_mvvm/domain/entities/item.dart';
import 'package:todo_mvvm/presentation/widgets/common_textfield.dart';
import 'package:todo_mvvm/providers/item_providers.dart'; 
import 'package:uuid/uuid.dart';

import '../../../core/assets/assets_constants.dart';
class AddUpdateTodoScreen extends ConsumerWidget {
  final Item? item; // If `item` is null, we're adding a new item.

  const AddUpdateTodoScreen({super.key, this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descriptionController =
        TextEditingController(text: item?.description ?? '');
    final formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey, // Attach the formKey to the Form widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image.asset(AssetsConstants.todoAddUP),

                  InkWell(
                    onTap: (){
                      context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                      child: Icon(Icons.arrow_back_outlined,),
                    ),
                  )
                ],
              ),
              CommonTextFormField(
                controller: titleController,
                hintText: "Title",
                prefixIcon: Icons.title_rounded,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 4),
              CommonTextFormField(
                controller: descriptionController,
                hintText: "Description",
                prefixIcon: Icons.description,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // If validation passes, proceed
                    final title = titleController.text.trim();
                    final description = descriptionController.text.trim();
                    final viewModel = ref.read(itemListViewModelProvider.notifier);

                    if (item == null) {
                      // Generate a unique ID
                      final newItem = Item(
                        id: const Uuid().v4(), // Generate a unique ID
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
                    // If validation fails, show a snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields.'),
                      ),
                    );
                  }
                },
                child: Text(item == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
