part of 'popover_cubit.dart';

@immutable
abstract class PopoverState {}

class PopoverInitial extends PopoverState {}

class ShowPopover extends PopoverState {}

class RemovePopover extends PopoverState {}
