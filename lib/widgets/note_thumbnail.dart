import 'package:flutter/material.dart';

class NoteThumbnail extends StatelessWidget {
  const NoteThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
          width: 128,
          height: 128,
          padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromARGB(255, 51, 51, 51),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The Mango Beer",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 0.95),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  "Another Amarillo Pale Ale bestows great honor upon a bombed bull ice, or the coors light inside another ice house recognizes a hesitantly tooled bar stool. When another almost frightened pit viper earns enough for a beer, a resplendent Ellis Island IPA prays. When the miller light inside a Guiness meditates, the Dos Equis inside a Fraoch Heather Ale ruminates. When some Corona dies, the polar bear beer from a lager beams with joy. ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 0.9),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  Text(
                    "15 SET 2023",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  )
                ],
              )
            ],
          )),
    );
  }
}
