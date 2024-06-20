import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cubits/login/login_cubit.dart';

class WaitingForm extends StatefulWidget {
  const WaitingForm({
    super.key,
  });

  @override
  State<WaitingForm> createState() => _WaitingFormState();
}

class _WaitingFormState extends State<WaitingForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Um e-mail será enviado para "${context.read<LoginCubit>().state.email}" com o seu link de acesso',
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
        OutlinedButton.icon(
          onPressed: () {
            context.read<LoginCubit>().cancel();
          },
          icon: const Icon(Icons.arrow_back_outlined),
          label: const Text('Voltar'),
        ),
      ],
    );
  }
}
