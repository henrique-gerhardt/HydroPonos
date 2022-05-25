import 'package:flutter/material.dart';
import 'package:tccapp/login.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
           accountName: const Text('Luciano Proes Gerhardt'),
           accountEmail: const Text('luciano@gmail.com'),
           currentAccountPicture: CircleAvatar(
             backgroundImage: Image.asset(
              'lib/assets/images/fakePerson.jpeg'
             ).image,
           ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Editar Perfil'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login(key: key,))
                );
            },
          ),
        ],
      ),
    );
  }
}