import 'package:bloc_demo/bloc/article_list_bloc.dart';
import 'package:bloc_demo/ui/article_list_screen.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ArticleListBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ArticleListScreen(),
      ),
    );
  }
}