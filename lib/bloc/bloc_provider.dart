import 'package:bloc_demo/bloc/bloc.dart';
import 'package:flutter/material.dart';

// The purpose of this class is inject the bloc into Flutter's widget tree

// BlocProvider is a generic class. Generic type T is scoped to be an object that implements
// the Bloc interface. This means the provider can store only BLoC objects
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  BlocProvider({Key? key, required this.bloc, required this.child})
      : super(key: key);

  // of method allows widgets to retrieve the BlocProvider from a descendant in the widget tree
  // with the current build context
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

  @override
  State<StatefulWidget> createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // build method is a passthrough to the widget's child. This won't render anything
  @override
  Widget build(BuildContext context) => widget.child;

  // When this widget is removed, this method is called to closes the stream
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
