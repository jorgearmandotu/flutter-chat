import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/widget/logo.dart';
import 'package:chat/widget/boton_azul.dart';
import 'package:chat/widget/labels.dart';
import 'package:chat/widget/custom_imput.dart';
import 'package:chat/helpers/mostrar_alerta.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.95),
            //constraints: const BoxConstraints.expand(),
            //height: MediaQuery.of(context).size.height * 0.9,
            //margin: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Logo(title: 'Messenger',),
        
                _Form(),
        
                const Labels( 
                  ruta: 'register',
                  label1: '¿No tienes cuenta?',
                  label2: 'Crea una ahora!',),
        
                const Text('términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200 ),)
              ],
            ),
          ),
        ),
      ),
   );
  }
}



class _Form extends StatefulWidget {

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>( context );
    
    return Container(
      margin:  const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          
          CustomImput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomImput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            isPassword: true,
            textController: passwordCtrl,
          ),

          BotonAzul(
            textBtn: 'Ingresar',
            onPressed: authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login( emailCtrl.text.trim(), passwordCtrl.text.trim() );

              if (loginOk){
                //TODO:conectar anuestro socket server
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Login Incorrecto', 'Las credenciales no coinciden');
              }
            },
          ),
          
          
        ],
      ),
    );
  }
}