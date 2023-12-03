import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yeezy_store/models/ownordermodel.dart';

import '../constants.dart';


class OrderItem extends StatelessWidget {
  OwnOrderModel ownOrderModel;
  int index;

  OrderItem({super.key,required this.ownOrderModel,required this.index});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.202,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),

              ),
              child:  Image(
                image: NetworkImage(getImage(ownOrderModel.orderData[index].productImage!)),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
             Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          ownOrderModel.orderData[index].productName!,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                   Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('qty :${ownOrderModel.orderData[index].quantity}',style: TextStyle(
                          fontSize: 18,
                        ),),
                      ),
                      Expanded(
                        flex: 2,
                        child: AutoSizeText('Size :${ownOrderModel.orderData[index].size}',style: TextStyle(
                          fontSize: 18,
                        ),),
                      ),

                    ],
                  ),
                   Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'totPrice :',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          children: [
                            TextSpan(
                              text: '\$${ownOrderModel.orderData[index].totalPrice!}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              )
                            )
                          ]
                          ),

              ),
                      ),
                    ],
                  ),
                   Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectionArea(
                            child: AutoSizeText('OrderCode :${ownOrderModel.orderData[index].orderCode}',maxLines: 1,style: TextStyle(
                              fontSize: 20,
                            ),),
                          ),
                        ),
                      ],
                    ),
                  )



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
