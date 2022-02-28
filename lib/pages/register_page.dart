import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/widget/boton_azul.dart';
import 'package:chat/widget/logo.dart';
import 'package:chat/widget/labels.dart';
import 'package:chat/widget/custom_imput.dart';

import '../helpers/mostrar_alerta.dart';
import '../services/auth_service.dart';
import '../services/socket_service.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);


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
                const Logo(title: 'Registro',),
        
                _Form(),

                const SizedBox(
                  height: 10,
                ),
        
                const Labels( 
                  ruta: 'login',
                  label1: 'Ya tienes una cuenta',
                  label2: 'Ingresa Ahora',
                  ),
        
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
  final nameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>( context );
    final socketService = Provider.of<SocketService>( context );
    
    return Container(
      margin:  const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          
          CustomImput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),

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
            textBtn: 'Crear Cuenta',
            onPressed: authService.autenticando ? null : () async {
              FocusScope.of( context).unfocus();
              final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passwordCtrl.text.trim());
              if(registerOk == true){
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else{
                mostrarAlerta(context, 'Registro Incorrecto', registerOk);
              }
            },
          ),
          
          
        ],
      ),
    );
  }
}