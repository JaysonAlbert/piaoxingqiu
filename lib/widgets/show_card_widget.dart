import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowCardWidget extends StatelessWidget {
  ShowCardWidget({Key? key, required this.showData}) : super(key: key);

  final Map<String, dynamic> showData;

  String _price() {
    final priceInfo = showData['minOriginalPriceInfo']! as Map<String, String>;
    return '${priceInfo['prefix']}${priceInfo['yuanNum']}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                height: 100,
                width: 77,
                imageUrl: showData['posterUrl'] as String,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            IntrinsicWidth(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          showData['showName'] as String,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          showData['showDate'] as String,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                '${showData['cityName'] as String}|${showData['venueName'] as String}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _price(),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Text('起')
                        ])
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
