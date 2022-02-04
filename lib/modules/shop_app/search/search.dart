import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app_app/model/shop_app/favorite_model.dart';
import 'package:shop_app_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_app/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:shop_app_app/modules/shop_app/search/cubit/search_state.dart';
import 'package:shop_app_app/modules/shop_app/search/widgets/search_rounded_fieled.dart';
import 'package:shop_app_app/shared/styles/colors.dart';

class SearchShopScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var searchContrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return (BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      
                      children: [
                        Container(
                            width: size.width * .9,
                            height: size.height * .05,
                            child: SearchFormField(
                              controller: searchContrller,
                              type: TextInputType.text,
                              label: 'Search',

                              prefix: Icons.search,
                              iconcolor: iconColor,

                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return (' Please enter your Name');
                                }
                                return null;
                              },
                              onSubmit: (String text) {
                                SearchCubit.get(context).searchData(text);

                              },
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        if (state is SearchLoadingState)
                          LinearProgressIndicator(),
                        if (state is SearchSuccessState)
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) => true,
                            widgetBuilder: (context) => Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => buildSearchItem(
                                      SearchCubit.get(context)
                                          .model!
                                          .data!
                                          .data[index],
                                      context,
                                      isOldPrice: false),
                                  separatorBuilder: (context, index) => Container(
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    height: 1,
                                  ),
                                  itemCount: SearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data
                                      .length),
                            ),
                            fallbackBuilder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ]),
                  ),
                ),
              ),
          );
        },
      ),
    )
    );
    }
  Widget buildSearchItem( data, context, {isOldPrice = true}) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
            width: 120,
            height: 120,
            child:
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(
                  data.image,
                ),
                width: double.infinity,
                height: 120,

                // fit: BoxFit.cover,
              ),
              if (data.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  child: Text(
                    'DICOUNT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
            ]),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              data.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(height: 1.4, fontSize: 14),
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  data.price.toString(),
                  overflow: TextOverflow.ellipsis,
                  // maxLines: 2,
                  style: TextStyle(fontSize: 12, color: defultColor),
                ),
                SizedBox(
                  width: 10,
                ),
                if (data.discount != 0 && isOldPrice)
                  Text(
                    '${data.oldPrice.toString()}',
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit .get(context)
                        .changeFavorites(data.id);
                    //print('');
                  },
                  icon: CircleAvatar(
                      radius: 14.0,
                      // ignore: dead_code
                      backgroundColor:
    ShopCubit.get(context).favourites[data.id] !?defultColor:

         Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                  iconSize: 14,
                ),
              ],

            ),
            ]
                  ),
                ),
              ])
    )
    );


  }
}
