import 'package:flutter/material.dart';
import 'widgets/nav_bar.dart';
import 'widgets/dashboard_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        drawer: NavBar(key: key),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [Container()],
          title: const Text('HydroPonos'),
          titleTextStyle: const TextStyle(
            fontSize: 22
            ),
          backgroundColor: theme.primaryColor,
        ),
        body: Container(
          color: const Color.fromARGB(255, 252, 253, 255),
          child: ListView(

            padding: const EdgeInsets.fromLTRB(4, 4, 4, 40),
            children:  [
              DashboardCard(
                title: 'Horta Central', 
                subtitle: 'Morango', 
                initialwaterFlow: 70, 
                temperature: '23', 
                humidity: '71'),
              DashboardCard(
                title: 'Horta Oeste', 
                subtitle: 'Alface', 
                initialwaterFlow: 60, 
                temperature: '23', 
                humidity: '76'),
              DashboardCard(
                title: 'Horta Sul', 
                subtitle: 'Alfafa', 
                initialwaterFlow: 10, 
                temperature: '22', 
                humidity: '57',
                problem: true,),
              DashboardCard(
                title: 'Horta Campo Novo', 
                subtitle: 'Morango', 
                initialwaterFlow: 50, 
                temperature: '25', 
                humidity: '77',),
              DashboardCard(
                title: 'Horta Rio do Sul', 
                subtitle: 'Tomate', 
                initialwaterFlow: 80, 
                temperature: '26', 
                humidity: '79',),
              DashboardCard(
                title: 'Horta Pinhal', 
                subtitle: 'Brócolis', 
                initialwaterFlow: 60, 
                temperature: '20', 
                humidity: '87',),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: theme.primaryColor,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Builder(
          builder: (context) => BottomAppBar(
            child: Container(
              decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
                  color: theme.primaryColor, 
                  width: 3.0)
            )
            ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.person),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
