import 'package:cuber/cuber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rubiks_solver/cube_solution/cube_solution.dart';
import 'package:rubiks_solver/gen/assets.gen.dart';

class CubeSolutionPage extends StatelessWidget {
  CubeSolutionPage({
    super.key,
    required this.moves,
  }) : assert(moves.isNotEmpty, 'Solution must have at least one move');

  final List<Move> moves;

  static Route<void> route(List<Move> moves) {
    return MaterialPageRoute<void>(
      builder: (_) => CubeSolutionPage(
        moves: moves,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: moves,
      child: BlocProvider(
        create: (context) => CubeSolutionCubit(moves: moves),
        child: const CubeSolutionView(),
      ),
    );
  }
}

class CubeSolutionView extends StatefulWidget {
  const CubeSolutionView({
    super.key,
  });

  @override
  State<CubeSolutionView> createState() => _CubeSolutionViewState();
}

class _CubeSolutionViewState extends State<CubeSolutionView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solution'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MovesCounter(),
            AspectRatio(
              aspectRatio: 3 / 4,
              child: MovesPageView(
                pageController: pageController,
              ),
            ),
            SolutionControls(
              pageController: pageController,
            ),
          ],
        ),
      ),
    );
  }
}

class MovesPageView extends StatelessWidget {
  const MovesPageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final moves = context.read<List<Move>>();
    return PageView.builder(
      controller: pageController,
      onPageChanged: (index) {
        context.read<CubeSolutionCubit>().pageChanged(index);
      },
      itemCount: moves.length,
      itemBuilder: (context, index) {
        final currentMove = moves[index];
        return currentMove.image.image(fit: BoxFit.fitHeight);
      },
    );
  }
}

class MovesCounter extends StatelessWidget {
  const MovesCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubeSolutionCubit, CubeSolutionState>(
      builder: (context, state) {
        final numberOfMoves = context.read<CubeSolutionCubit>().movesCount;
        return Center(
          child: Text(
            'Move ${state.index + 1} / $numberOfMoves',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      },
    );
  }
}

class SolutionControls extends StatelessWidget {
  const SolutionControls({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final isLastStep = context.select<CubeSolutionCubit, bool>(
      (cubit) => cubit.state.isLastStep,
    );
    final isFirstStep = context.select<CubeSolutionCubit, bool>(
      (cubit) => cubit.state.isFirstStep,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: isFirstStep
              ? null
              : () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
          child: const Text('Previous'),
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: isLastStep
              ? null
              : () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
          child: const Text('Next'),
        ),
      ],
    );
  }
}

extension MoveExtensions on Move {
  AssetGenImage get image {
    if (this == Move.up) {
      return Assets.moves.u;
    }
    if (this == Move.down) {
      return Assets.moves.d;
    }
    if (this == Move.front) {
      return Assets.moves.f;
    }
    if (this == Move.back) {
      return Assets.moves.b;
    }
    if (this == Move.right) {
      return Assets.moves.r;
    }
    if (this == Move.left) {
      return Assets.moves.l;
    }
    if (this == Move.upInv) {
      return Assets.moves.uDash;
    }
    if (this == Move.downInv) {
      return Assets.moves.dDash;
    }
    if (this == Move.frontInv) {
      return Assets.moves.fDash;
    }
    if (this == Move.backInv) {
      return Assets.moves.bDash;
    }
    if (this == Move.rightInv) {
      return Assets.moves.rDash;
    }
    if (this == Move.leftInv) {
      return Assets.moves.lDash;
    }
    if (this == Move.upDouble) {
      return Assets.moves.u2;
    }
    if (this == Move.downDouble) {
      return Assets.moves.d2;
    }
    if (this == Move.frontDouble) {
      return Assets.moves.f2;
    }
    if (this == Move.backDouble) {
      return Assets.moves.b2;
    }
    if (this == Move.rightDouble) {
      return Assets.moves.r2;
    }
    if (this == Move.leftDouble) {
      return Assets.moves.l2;
    }
    throw StateError('Move is not possible');
  }
}
