import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/widgets/floating_options_button.dart';
import 'package:hello_world/widgets/template_cover.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const TemplateCover(
            renderBacklink: true,
          ),
          Expanded(
              child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 22,
                          ),
                          Text(
                            "15SET2023 | Sáb. 14:23",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      Text(
                        "Meu primeiro título",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem magna, rhoncus a mi in, dictum viverra nulla. Mauris sit amet risus magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nunc sed mattis urna. Quisque molestie aliquam est in accumsan. Aenean ac maximus orci, sed tincidunt leo. Nunc efficitur tristique lectus, ac tempus diam accumsan ut. Phasellus vel odio quis risus egestas ultricies nec sit amet lorem. Integer a pulvinar metus. Proin et eros felis. Etiam ac sagittis massa. Quisque ac mi in ex sollicitudin facilisis. Pellentesque tristique pretium magna sodales feugiat. Donec vel orci nec enim scelerisque cursus non non elit. Donec placerat est nec ex suscipit, a faucibus augue imperdiet. Suspendisse vitae feugiat urna.In mollis molestie malesuada.\n\nNullam ornare feugiat dui, non sollicitudin arcu consectetur vitae. Curabitur id dui finibus, consectetur orci sit amet, consequat ligula. Proin consequat ipsum ex, viverra accumsan nisi congue et. Ut massa quam, venenatis id dolor eget, cursus laoreet lorem. Suspendisse vel facilisis lorem. Pellentesque ullamcorper velit vel neque ornare, quis euismod velit ornare. Aliquam nec est ut nisl tempus sagittis ac et neque. Sed ligula sem, dapibus a lectus eget, egestas accumsan neque. Donec nec vulputate nunc. Phasellus laoreet sit amet metus nec pretium. Sed ultricies mollis mi sed suscipit. Nulla accumsan, nunc et efficitur tincidunt, arcu lectus luctus libero, at volutpat eros nulla nec mi. Integer purus augue, scelerisque ac convallis nec, finibus sit amet urna. Aliquam erat volutpat. Suspendisse dignissim at quam id pellentesque. ",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 64)
            ],
          ))
        ],
      ),
      floatingActionButton: const FloatingOptionsButton(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
