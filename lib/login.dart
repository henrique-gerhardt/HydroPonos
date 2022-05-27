import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'dashboard.dart';

const users = {
  'henrique.gerhardt@hotmail.com': '12345',
  'luan@fahor.com.br': '12345',
  'paulo@fahor.com.br': '12345'
};

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 1250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        logoWidth: 2,
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 53, 149, 76),
        ),
        primaryColor: Colors.white,
        buttonTheme: const LoginButtonTheme(
          backgroundColor: Colors.teal
        ),
        inputTheme: const InputDecorationTheme(
          filled: true,
          fillColor:  Colors.white,
        ),
        bodyStyle: const TextStyle(
          color: Colors.white,
        )


      ),
      logo:const Image(
        image: Svg('lib/assets/svg/logo.svg'),
        width: 1200,
        height: 1200,
      ).image,
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: 'Usuário', 
        passwordHint: 'Senha',
        confirmPasswordHint: 'Confirmar Senha',
        loginButton: 'Entrar',
        signupButton: 'Inscrever-se',
        forgotPasswordButton: 'Esqueci a senha',
        recoverPasswordButton: 'Recuperar',
        goBackButton: 'Voltar',
        confirmPasswordError: 'Usuário ou senha incorretos!',
        recoverPasswordIntro: 'Redefinir senha',
        recoverPasswordDescription: 'Enviaremos um e-mail com as instruções de recuperação',
        recoverPasswordSuccess: 'Email enviado com sucesso!',
        ),
        
    );
  }
}
