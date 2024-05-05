import 'package:flutter/material.dart';
import 'package:piaoxingqiu/models/order.dart';
import 'package:go_router/go_router.dart';

class AudienceListWdiget extends StatefulWidget {
  final List<Audience> audiences;

  const AudienceListWdiget({super.key, required this.audiences});

  @override
  State<AudienceListWdiget> createState() => _AudienceListWdigetState();
}

class _AudienceListWdigetState extends State<AudienceListWdiget> {
  Set<int> _selectedAudience = {};

  @override
  Widget build(BuildContext context) {
    List<Widget> audienceTiles = List<Widget>.generate(widget.audiences.length,
        (index) => _createAudience(widget.audiences[index], index));

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("实名观演/赛人"), Text("已选中0/1位，入场时需携带对应证件")],
                ),
                TextButton(
                    onPressed: () => {context.push("/audience/add")},
                    child: Text("添加"))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ...audienceTiles
          ],
        ),
      ),
    );
  }

  Widget _createAudience(Audience audience, int index) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          if (_selectedAudience.contains(index)) {
            setState(() {
              _selectedAudience.remove(index);
            });
          } else {
            setState(() {
              _selectedAudience.add(index);
            });
          }
        },
        selected: _selectedAudience.contains(index),
        style: ListTileStyle.list,
        title: Text(audience.name),
        subtitle: Text('${audience.idType} ${audience.idNo}'),
        trailing: _selectedAudience.contains(index)
            ? Icon(Icons.check_circle)
            : Icon(Icons.circle_outlined),
      ),
    );
  }
}
