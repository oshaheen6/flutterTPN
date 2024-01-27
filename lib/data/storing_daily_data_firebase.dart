
/////////// repository   /////////

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:your_app/models/category.dart';
import 'package:your_app/models/product.dart';
import 'package:your_app/cubit/data_cubit.dart';

class DataRepository {
  Future<list<category>> fetchCategories() async {
    // ... fetch categories from Firestore
  }

  Future<List<Product>> fetchProducts() async {
    // ... fetch products from Firestore
  }
}


////////   cubit   ////////////////


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app/models/category.dart';
import 'package:your_app/models/product.dart';
import 'package:your_app/data_repository.dart';

class DataCubit extends Cubit<DataState> {
  final DataRepository _repository;

  DataCubit(this._repository) : super(DataInitial());

  Future<void> fetchData() async {
    final categories = await _repository.fetchCategories();
    final products = await _repository.fetchProducts();
    emit(DataLoaded(categories: categories, products: products));
  }
}

///////////// UI ///////////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app/cubit/data_cubit.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              // ... display product details
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
 

