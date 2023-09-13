import 'package:flutter/material.dart';
import 'package:green/src/models/item_model.dart';
import 'package:green/src/pages/product/product_screen.dart';
import 'package:green/src/services/utils_services.dart';
import '../../../config/custom_colors.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;

  ItemTile({Key? key, required this.item}) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (c) {
              return ProductScreen(item: item);
            }));
          },
          child: Card(
            // Conteúdo
            elevation: 3,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Imagem
                    Expanded(
                      child: Hero(
                        tag: item.imgUrl,
                        child: Image.asset(item.imgUrl)),
                    ),

                    // Nome
                    Text(
                      item.itemName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Preço
                    Row(
                      children: [
                        Text(
                          utilsServices.priceToCurrency(item.price),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.customSwatchColor,
                          ),
                        ),
                        Text('/${item.unit}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ]),
            ),
          ),
        ),

        // Botão de adicionar no carrinho
        Positioned(
          top: 4,
          right: 4,
          child: Container(
              height: 40,
              width: 35,
              decoration: BoxDecoration(
                  color: CustomColors.customSwatchColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: const Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
                size: 20,
              )),
        )
      ],
    );
  }
}
