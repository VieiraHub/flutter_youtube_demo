import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Home extends StatefulWidget {

  String search2;
  Home(this.search2);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _listVideos(String search){
    Api api = Api();
    return api.searching(search);
  }

  @override
  void initState() {
    super.initState();
    print("chamado 1 - initstate");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 - didChangeDependencies");
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("chamado 2 - didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("chamado 4 - dispose");
  }

  @override
  Widget build(BuildContext context) {

    print("chamado 3 - build");

    return FutureBuilder<List<Video>> (
        future: _listVideos( widget.search2 ),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch( snapshot.connectionState ){
            case ConnectionState.none :
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active :
            case ConnectionState.done :
              if(snapshot.hasData) {

                return ListView.separated(
                    itemBuilder: (context, index){

                      List<Video> videos = snapshot.data;
                      Video video = videos[index];

                      return GestureDetector(
                        onTap: (){
                          FlutterYoutube.playYoutubeVideoById(
                              apiKey: YOUTUBE_API_KEY,
                              videoId: video.id,
                            autoPlay: true,
                            fullScreen: true
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(video.image)
                                  )
                              ),
                            ),
                            ListTile(
                              title: Text(video.title),
                              subtitle: Text(video.channel),
                            )
                          ],
                        )
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    itemCount: snapshot.data.length
                );
              } else {
                return Center(
                  child: Text("No data to be displayed"),
                );
              }
              break;
          }
        },
    );
  }
}
