import 'dart:collection';

import 'package:flutter/material.dart';
import '../utils.dart';

class FlowChange extends Notification {
  final int seq;
  final double value;
  FlowChange(this.seq, this.value);
}

class DashboardCard extends StatefulWidget {
   DashboardCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.initialwaterFlow,
      required this.temperature,
      required this.humidity,
      this.problem = false})
      : super(key: key);

  final String title;
  final String subtitle;
  final double initialwaterFlow;
  final String temperature;
  final String humidity;
  final bool problem;

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {

  final ValueNotifier<FlowChange> _notifier = ValueNotifier(FlowChange(1, 20));
  HashMap<int, double> flows = HashMap();
  
  @override
  Widget build(BuildContext context) {
    flows.addAll({1: 20.0});
    flows.addAll({2: 20.0});
    flows.addAll({3: 20.0});
    flows.addAll({4: 20.0});
    flows.addAll({5: 20.0});
    flows.addAll({6: 20.0});
    flows.addAll({7: 20.0});
    flows.addAll({8: 20.0});
    flows.addAll({9: 20.0});
    flows.addAll({10: 20.0});
    flows.addAll({11: 20.0});
    flows.addAll({12: 20.0});
    flows.addAll({13: 20.0});
    flows.addAll({14: 20.0});
    return Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: (Colors.blue[100])!, width: 1.0),
            borderRadius: BorderRadius.circular(4.0)),
        elevation: 4,
        child: NotificationListener<FlowChange>(
          child: ExpansionTile(
            //Pesquisar sobre ListTileTheme caso não gostar da cor
            title: ValueListenableBuilder(
              valueListenable: _notifier,
              builder: (context, FlowChange val, child) {
                flows[val.seq] = val.value;
                double sum = flows.values.reduce((value, element) => value + element);
                double flowValue = double.parse((sum / 14).toStringAsFixed(2));
                return CardDashboardTitle(widget: widget, flow: flowValue);
              },
              ),
            children: [
              CardDashboardBody(
                sequencial: 1,
              ),
              CardDashboardBody(
                sequencial: 2,
              ),
              CardDashboardBody(
                sequencial: 3,
              ),
              CardDashboardBody(
                sequencial: 4,
              ),
              CardDashboardBody(
                sequencial: 5,
              ),
              CardDashboardBody(
                sequencial: 6,
              ),
              CardDashboardBody(
                sequencial: 7,
              ),
              CardDashboardBody(
                sequencial: 8,
              ),
              CardDashboardBody(
                sequencial: 9,
              ),
              CardDashboardBody(
                sequencial: 10,
              ),
              CardDashboardBody(
                sequencial: 11,
              ),
              CardDashboardBody(
                sequencial: 12,
              ),
              CardDashboardBody(
                sequencial: 13,
              ),
              CardDashboardBody(
                sequencial: 14,
              ),
            ],
          ),
          onNotification: (n) {
            _notifier.value = n;
            return true;
          },
        ));
  }
  @override
  void dispose() {
      _notifier.dispose();

      super.dispose();
  }
}

class CardDashboardBody extends StatefulWidget {
  CardDashboardBody({required this.sequencial, Key? key}) : super(key: key);
  final int sequencial;
  @override
  State<CardDashboardBody> createState() => _CardDashboardBodyState();
}

class _CardDashboardBodyState extends State<CardDashboardBody> {
  _CardDashboardBodyState();
  double currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(clipBehavior: Clip.none, children: [
        Icon(
          Icons.oil_barrel_outlined,
          color: Colors.blue[300],
        ),
        Positioned(
          right: (widget.sequencial.toString().length > 1 ? -12 : -8),
          bottom: -2,
          child: Text("${widget.sequencial}",
              style: TextStyle(color: Colors.blue[300])),
        )
      ]),
      title: Slider(
        value: currentSliderValue,
        max: 100,
        divisions: 5,
        label: "${currentSliderValue.round().toString()}%",
        onChanged: (double value) {
          setState(() {
            currentSliderValue = value;
          });
          FlowChange(widget.sequencial, value).dispatch(context);
        },
      ),
    );
  }
}

class CardDashboardTitle extends StatelessWidget {
  const CardDashboardTitle({
    Key? key,
    required this.widget,
    required this.flow,
  }) : super(key: key);

  final DashboardCard widget;
  final double flow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(children: [
            ListTile(
              title: Text(widget.title),
              subtitle: Text(widget.subtitle),
            ),
            if (widget.problem) const ProblemSign()
          ]),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardCardProperty(
                  icon: Icons.water,
                  color: Colors.blue,
                  description: '$flow%'),
              DashboardCardProperty(
                  icon: Icons.thermostat,
                  color: (Colors.orange[400])!,
                  description: '${widget.temperature}\u00B0'),
              DashboardCardProperty(
                  icon: Icons.water_drop_outlined,
                  color: Colors.lightBlueAccent,
                  description: '${widget.humidity}%'),
            ],
          )
        ],
      ),
    );
  }
}

class ProblemSign extends StatelessWidget {
  const ProblemSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 5,
        child: IconButton(
          icon:
              const Icon(Icons.report_problem, color: Colors.deepOrangeAccent),
          onPressed: () {
            showAlertDialog(
                context,
                'Alerta de Fluxo!',
                'O fluxo de água está abaixo do indicado, aumentar o fluxo da bomba?',
                [
                  TextButton(
                    child: const Text('AUMENTAR O FLUXO'),
                    onPressed: () {
                      Navigator.pop(context, 'Raise');
                    },
                  ),
                  TextButton(
                    child: const Text('CANCELAR'),
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                ]);
          },
        ));
  }
}

class DashboardCardProperty extends StatelessWidget {
  const DashboardCardProperty(
      {Key? key,
      required this.icon,
      required this.color,
      required this.description})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(children: [
        Icon(
          icon,
          color: color,
        ),
        Text(description)
      ]),
    );
  }
}
