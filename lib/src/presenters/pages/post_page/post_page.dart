import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/config/router/app_router.dart';
import 'package:scaped/src/presenters/cubits/post/post_state.dart';
import 'package:scaped/src/presenters/widgets/scaffold_base.dart';

import '../../../domain/models/post.dart';
import '../../cubits/post/post_cubit.dart';
import '../state/page_state.dart';

class PostPage extends StatefulWidget {
  final Post? post;
  const PostPage({
    this.post,
    super.key,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends PageState<PostPage, PostCubit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titulo = TextEditingController();
  final TextEditingController _publicacao = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _titulo.text = widget.post?.title ?? '';
      _publicacao.text = widget.post?.issue ?? '';
      controller.post = widget.post;
    }
  }

  @override
  void dispose() {
    _titulo.dispose();
    _publicacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(
      body: BlocConsumer<PostCubit, PostState>(
        bloc: controller,
        listener: (context, state) async {
          if (state is SuccessPostState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                content: const Text('A Publicação foi gravada com sucesso!'),
                actions: [
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () => Modular.to.popUntil(ModalRoute.withName(appRouter.homeRoute)),
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
                      label: Text('Título'),
                    ),
                    controller: _titulo,
                    validator: (value) => value != null ? (value.isEmpty ? 'Campo não pode ser vazio!' : null) : null,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        label: Text('Publicação'),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 100,
                      controller: _publicacao,
                      validator: (value) => value != null ? (value.isEmpty ? 'Campo não pode ser vazio!' : null) : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FilledButton.icon(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      controller.savePost(_titulo.text, _publicacao.text);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Publicar'),
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
