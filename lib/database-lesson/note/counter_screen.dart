import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:techcity/viewmodel/note_viewmodel.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildCart(int cartValue) {
      return Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0, bottom: 16),
            child: Icon(
              Icons.shopping_cart,
              size: 24,
            ),
          ),
          Positioned(
            right: 8,
            child: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepOrange),
                child: Center(
                    child: Text(
                  cartValue.toString(),
                  style: const TextStyle(color: Colors.white),
                ))),
          )
        ],
      );
    }

    return ScopedModel<NoteViewModel>(
      model: NoteViewModel(),
      child: ScopedModelDescendant<NoteViewModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              actions: [buildCart(model.cart)],
            ),
            body: const Column(
              children: [],
            ),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                model.updateCart();
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(12)),
                child: const Center(
                    child: Text(
                  'Add to card',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
