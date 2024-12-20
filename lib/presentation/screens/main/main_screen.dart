
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/viewmodels/item_list_view_model.dart';


class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: itemListState.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.description),
              onTap: () => context.push('/edit', extra: item),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(itemListViewModelProvider.notifier).deleteItem(item.id);
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}