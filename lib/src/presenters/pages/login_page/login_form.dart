import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/utils/resources/validators.dart';

import '../../cubits/login/login_cubit.dart';

class LoginForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
            ),
            validator: (value) => !Validators.validateEmail(value) ? 'E-mail inválido!' : null,
          ),
          const SizedBox(height: 4),
          FilledButton.icon(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              context.read<LoginCubit>().signIn(email: _emailController.text);
            },
            icon: const Icon(Icons.login),
            label: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
