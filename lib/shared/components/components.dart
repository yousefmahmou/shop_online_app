import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/cubit_shop_app/cubit_shop_app.dart';
import 'package:shop_app/shared/styles/colors.dart';

//هنعمل ويدجيت فيه الزرار لاننا هنستخدمه كتير
//هنحط اسم الزرار وفيه الكونتينر كله
//وهنعمل بارميترز في الديفولت بوتون فيه وعشان بنستخدمهم كتير ف هنعمل داتا تيب للويدث والكولور
//والاستخدم الاكتر بعمله انيشيال فاليو والاقل استخدام بعمله ريكويرد
//والدوسه بتاعت الزرار اللي هي اون بريسد دي بتتغير من زرار للتاني
//ف هنعملها داتا تيب اسمها فانكشن
//وبرضه للتيكست نعملها ك داتا تيب
//ونبعت الديفولت بوتون ده لسكرينه اللوجين مكانها ونحط القيم فيها واللي مش هستخدمه كتير محطوش او اللي مش ريكويرد
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 10.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: function(),
      child: Text(
        text.toUpperCase(),
      ),
    );

//اي حاجه فيهااننوس ميثود بتاخد فانكشن لانها فانكشن
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchange,
  Function? onTap,
  bool ispassword = false,
  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixpressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (value) {
        onsubmit!(value);
      },
      onChanged: (value) {
        onchange!(value);
      },
      onTap: () {
        onTap!();
      },
      // validator: (value) {
      // validate(value);
      //},
      validator: validate,
      obscureText: ispassword,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
//دي مهام عشان تتكرر

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      // onTap: () {
      //navigateTo(
      // context,
      // WebViewScreen(article['url']),
      // );
      // },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndfinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.old_price.round()}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
