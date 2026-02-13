import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/products/data/repository/product_repository.dart';
import 'package:product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:product_listing_app/features/products/presentation/bloc/product_event.dart';
import 'package:product_listing_app/features/products/presentation/screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(ProductRepository())..add(FetchProducts()),
        ),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Products App',
        home: const ProductListScreen(),
      ),
    );
  }
}
