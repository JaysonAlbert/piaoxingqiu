import 'package:flutter/material.dart';
import 'package:piaoxingqiu/models/order.dart';
import 'package:go_router/go_router.dart';
import 'package:piaoxingqiu/services/user_service.dart';

import 'package:piaoxingqiu/widgets/text_button_with_icon.dart';

class AudienceListWdiget extends StatefulWidget {
  final List<Audience> audiences;
  final int maxAudience;

  const AudienceListWdiget(
      {super.key, required this.audiences, required this.maxAudience});

  @override
  State<AudienceListWdiget> createState() => _AudienceListWdigetState();
}

class _AudienceListWdigetState extends State<AudienceListWdiget> {
  Set<String> _selectedAudience = {};

  List<Audience> allAudiences = [];

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Text("实名观演/赛人"),
                    Text(
                        "已选中${_selectedAudience.length}/${widget.maxAudience}位，入场时需携带对应证件")
                  ],
                ),
                TextButtonWithIcon(
                  onPressed: () => {context.push("/audience/add")},
                  label: Text("添加"),
                  icon: Icon(Icons.chevron_right),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AudienceListChild(
              selectedAudience: _selectedAudience,
              audiences: widget.audiences,
              maxAudience: widget.maxAudience,
            ),
            SizedBox(height: 10),
            TextButtonWithIcon(
                onPressed: () async {
                  allAudiences = await UserService().getAudiences();

                  if (!mounted) {
                    return;
                  }
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: this.context,
                      builder: (context) {
                        return PopScope(
                          onPopInvoked: (didPop) {},
                          child: Scaffold(
                            appBar: AppBar(title: Text("观演/赛人")),
                            body: SizedBox(
                              width: 1000,
                              child: AudienceListChild(
                                selectedAudience: _selectedAudience,
                                audiences: allAudiences,
                                maxAudience: widget.maxAudience,
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.expand_more),
                label: Text("查看更多"))
          ],
        ),
      ),
    );
  }
}

class AudienceListChild extends StatefulWidget {
  final Set<String> selectedAudience;
  final List<Audience> audiences;
  final int maxAudience;

  const AudienceListChild(
      {super.key,
      required this.selectedAudience,
      required this.audiences,
      required this.maxAudience});

  @override
  State<AudienceListChild> createState() => _AudienceListChildState();
}

class _AudienceListChildState extends State<AudienceListChild> {
  @override
  Widget build(BuildContext context) {
    List<Widget> audienceTiles = List<Widget>.generate(widget.audiences.length,
        (index) => _createAudience(widget.audiences[index]));
    return Column(
      children: audienceTiles,
    );
  }

  Widget _createAudience(Audience audience) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          //包含则移除
          if (widget.selectedAudience.contains(audience.id)) {
            setState(() {
              widget.selectedAudience.remove(audience.id);
            });
            return;
          }

          //超出上限
          if (widget.selectedAudience.length >= widget.maxAudience) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(child: Text("最多选择${widget.maxAudience}位观影人"))));
            return;
          }

          //新增
          setState(() {
            widget.selectedAudience.add(audience.id);
          });
        },
        selected: widget.selectedAudience.contains(audience.id),
        style: ListTileStyle.list,
        title: Text(audience.name),
        subtitle: Text('${audience.idType} ${audience.idNo}'),
        trailing: widget.selectedAudience.contains(audience.id)
            ? Icon(Icons.check_circle)
            : Icon(Icons.circle_outlined),
      ),
    );
  }
}
