
// Provider for ProfileViewModel
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_mvvm/domain/entities/user.dart';
import 'package:todo_mvvm/viewmodels/profile_view_model.dart';

final profileViewModelProvider =
    AsyncNotifierProvider<ProfileViewModel, User>(ProfileViewModel.new);