import 'package:flutter/material.dart';
import 'package:green/src/config/custom_colors.dart';
import 'package:green/src/pages/common_widgets/payment_dialog.dart';
import 'package:green/src/services/utils_services.dart';
import 'package:green/src/config/app_data.dart' as appdata;
import '../../models/cart_idem_model.dart';
import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      appdata.cartItems.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in appdata.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appdata.cartItems.length,
              itemBuilder: (_, index) {
                return CartTile(
                  cartItem: appdata.cartItems[index],
                  remove: removeItemFromCart,
                );
              },
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Total geral',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    utilsServices.priceToCurrency(cartTotalPrice()),
                    style: TextStyle(
                      fontSize: 23,
                      color: CustomColors.customSwatchColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        bool? result = await showOrderConfirmation();
                        if (result ?? false) {
                          Future.delayed(Duration.zero, () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return PaymentDialog(
                                  order: appdata.orders.first,
                                );
                              },
                            );
                          });
                        }
                      },
                      child: const Text(
                        'Concluir pedido',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
