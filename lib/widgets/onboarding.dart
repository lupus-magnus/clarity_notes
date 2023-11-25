import 'package:flutter/material.dart';
import 'package:hello_world/screens/create_category_setup.dart';
import 'package:hello_world/widgets/button.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller,
          children: const [
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.85),
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const SlideEffect(activeDotColor: Colors.black),
            )),
      ],
    ));
  }
}

class PageHeading extends StatelessWidget {
  final String text;
  const PageHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class PageBody extends StatelessWidget {
  final String text;
  const PageBody({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}

class SlidePage extends StatelessWidget {
  final String title;
  final String body;
  final String? animation;
  const SlidePage(
      {super.key, required this.title, required this.body, this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        PageHeading(text: title),
        if (animation != null) Lottie.asset(animation!, height: 240),
        PageBody(
          text: body,
        ),
      ]),
    ));
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlidePage(
        title: "Esse é o seu espaço!",
        animation: "assets/animations/creativity.json",
        body:
            "Descubra a magia dos cadernos digitais. Crie e personalize seus próprios cadernos para organizar suas ideias de maneira única.");
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlidePage(
        title: "Anotações à sua maneira!",
        animation: "assets/animations/write_heart.json",
        body:
            "Registre pensamentos, listas e inspirações. Adicione capas, emojis e até mesmo destaque às suas anotações e cadernos preferidos. A personalização é toda sua!");
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SlidePage(
            title: "Hora de começar!",
            animation: "assets/animations/books.json",
            body:
                "Pronto para dar vida às suas ideias? Toque em \"Criar Caderno\" e comece sua jornada de criatividade. Seu primeiro caderno está a um toque de distância! 🚀"),
        Container(
          alignment: const Alignment(0, 0.65),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Button(
                  text: "Criar caderno",
                  highlight: true,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateCategorySetup(),
                      ),
                    );
                  })),
        )
      ],
    );
  }
}
