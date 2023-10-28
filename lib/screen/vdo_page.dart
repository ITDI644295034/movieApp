import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../config/network_service.dart';
import '../model/vdo_model.dart';

class VdoPage extends StatefulWidget {
  const VdoPage({super.key});

  @override
  State<VdoPage> createState() => _VdoPageState();
}

class _VdoPageState extends State<VdoPage> {
  Future<VideoModel>? _vdoModel;
  String? _id;

  @override
  Widget build(BuildContext context) {
    Object? argumrnts = ModalRoute.of(context)!.settings.arguments;
    _id = argumrnts.toString();
    _vdoModel = ServiceNetwork().getClipDio(_id ?? '');
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Text(
          'VDO',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
          child: FutureBuilder(
        future: _vdoModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.results?.length,
              itemBuilder: (context, index) {
                var vdo = snapshot.data?.results?[index];
                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: vdo?.key ?? '',
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                );
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            vdo?.name ?? '',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                        YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.amber,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            print('eroore');
            print('');
            return Container(
              child: Text('${snapshot}',style: TextStyle(color: Colors.white),),
            );
          }
        },
      )),
    );
  }
}
