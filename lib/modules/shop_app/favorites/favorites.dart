import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app_app/model/shop_app/favorite_model.dart';
import 'package:shop_app_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_app/modules/shop_app/cubit/states.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';
import 'package:shop_app_app/shared/styles/colors.dart';

class  FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return
                  Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>
              state is ! ShopLoadingGetFavDataState,

              widgetBuilder: (BuildContext context) =>
                  ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> buildFavItem(ShopCubit.get(context).favoriteModel!.data!.data[index],context) ,
                      separatorBuilder: (context,index)=>myDivider(),
                      itemCount: ShopCubit.get(context).favoriteModel!.data!.data.length),

              fallbackBuilder: (BuildContext context) =>
                  Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
  Widget buildFavItem (FavoritesData? model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 125.0,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage(
                 model!.product!.image! ,),
                width: 120.0,
                height: 120.0,
              ),
              if(
               model.product?.discount
               !=0)

                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(

                    color: Colors.red,
                    child: Text('DISCOUNT', style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),),
                  ),
                ),

            ],
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  model.product!.name!,                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12.0,
                      height: 1.5
                  ),
                ),
                Spacer(),
                Row(
                    children:[
                      Text(
                        model.product!.price.toString(),
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(
                      model.product?.discount!=0)
                        Text(
                           '${ model.product!.oldPrice.toString()}',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 10.0,
                            color:Colors.grey ,
                            decoration: TextDecoration.lineThrough,

                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: (){
                             ShopCubit.get(context).changeFavorites(model.product!.id);
                            // print(model.id);

                          },
                          icon:CircleAvatar(
                            backgroundColor:
                             ShopCubit.get(context).favourites[model.product?.id] !?defultColor:
                            Colors.grey,
                            radius: 15.0,
                            child: Icon( Icons.favorite_border,size: 14.0,color: Colors.white,

                            ),
                          ))

                    ]
                ),
              ],
            ),
          ),


        ],

      ),
    ),
  );

}
