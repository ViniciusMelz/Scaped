import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/presenters/cubits/user/user_cubit.dart';
import 'package:scaped/src/presenters/cubits/user/user_state.dart';
import 'package:scaped/src/presenters/widgets/scaffold_base.dart';

import '../../../domain/models/user.dart';
import '../state/page_state.dart';

class UserPage extends StatefulWidget {
  final User? user;
  const UserPage({
    this.user,
    super.key,
  });

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends PageState<UserPage, UserCubit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _avatar = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (mounted) {
      controller.loadUser().then((value) {
        if (value.firstOrNull == null) {
          return;
        }

        _name.text = value.firstOrNull?.name ?? '';
        _lastName.text = value.firstOrNull?.lastName ?? '';
        _avatar.text = value.firstOrNull?.avatar ?? '';
        controller.user = value.firstOrNull;
      });
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _lastName.dispose();
    _avatar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(
      body: BlocConsumer<UserCubit, UserState>(
        bloc: controller,
        listener: (context, state) async {
          if (state is SuccessUserState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                content: const Text('Usuário gravado com sucesso!'),
                actions: [
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () => Modular.to.pop(),
                  )
                ],
              ),
            );
          }
        },
        builder: (context, state) => Form(
          key: _formKey,
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    controller: _name,
                    validator: (value) => value != null ? (value.isEmpty ? 'Campo não pode ser vazio!' : null) : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Sobrenome'),
                    ),
                    controller: _lastName,
                    validator: (value) => value != null ? (value.isEmpty ? 'Campo não pode ser vazio!' : null) : null,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Visibility(
                          visible: _avatar.text.isNotEmpty,
                          replacement: const Icon(Icons.person),
                          child: Image.network(
                            _avatar.text,
                            errorBuilder: (_, __, ___) => const Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Link para foto de perfil'),
                          ),
                          controller: _avatar,
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      controller.saveUser(_name.text, _lastName.text, _avatar.text);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
