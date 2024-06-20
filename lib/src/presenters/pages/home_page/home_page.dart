import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/config/router/app_router.dart';
import 'package:scaped/src/presenters/pages/state/page_state.dart';

import '../../cubits/home/home_cubit.dart';
import '../../cubits/home/home_state.dart';
import '../../widgets/post_card.dart';
import '../../widgets/scaffold_base.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageState<HomePage, HomeCubit> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(
      drawer: [
        FilledButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Publicar'),
          onPressed: () => Modular.to.popAndPushNamed(appRouter.postRoute).then((_) => controller.refresh()),
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.article),
          label: const Text('Minhas publicações'),
          onPressed: () => Modular.to.popAndPushNamed(appRouter.myPostsRoute).then((_) => controller.refresh()),
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.brightness_high),
          label: const Text('Alterar tema'),
          onPressed: () => controller.changeTheme(),
        ),
        OutlinedButton.icon(
          label: const Text('Sair'),
          icon: const Icon(Icons.logout),
          onPressed: () => controller.logOut(),
        ),
      ],
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: controller,
        builder: (context, state) => switch (state) {
          LoadingHomeState() => const Center(
              child: CircularProgressIndicator(),
            ),
          LoadedHomeState() => RefreshIndicator(
              onRefresh: () => controller.refresh(),
              child: ListView.builder(
                itemCount: state.posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.posts.length) {
                    return const Center(
                      child: Text(
                        'Você chegou ao fim da lista para os filtros selecionados',
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return PostCard(
                      post: state.posts[index],
                      onTap: () => Modular.to.pushNamed(
                        appRouter.postDetailsRoute,
                        arguments: state.posts[index],
                      ),
                    );
                  }
                },
              ),
            ),
          ErrorHomeState() => RefreshIndicator(
              onRefresh: () => controller.refresh(),
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      'Ocorreu um erro ao carregar a lista: ${state.error}',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
        },
      ),
    );
  }
}
