import 'package:flutter/material.dart';
import 'package:newsapp/Screens/webViewScreen.dart';

Widget businessItem(busineddItem, BuildContext ctx) => InkWell(
      onTap: () {
        Navigator.of(ctx).push(MaterialPageRoute(
            builder: (_) => webViewScreen(busineddItem['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 130.0,
              height: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: busineddItem['urlToImage'] == null
                        ? NetworkImage(
                            "https://www.rossendaleplayers.org.uk/Public/images/imagenotfound.jpg")
                        : NetworkImage(
                            busineddItem['urlToImage'],
                          ),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 130.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      busineddItem['title'],
                      style: Theme.of(ctx).textTheme.bodyText1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Text(
                        busineddItem['description'] == null
                            ? "No Descreption"
                            : busineddItem['description'],
                        style: Theme.of(ctx).textTheme.bodyText2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Text(
                      "Date: ${busineddItem['publishedAt']} ",
                      style: Theme.of(ctx).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget dividerItem() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 12.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.black,
      ),
    );
