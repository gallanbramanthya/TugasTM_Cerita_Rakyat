import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final player = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();
  double _volume = 0.5;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
    player.onDurationChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    if (_duration.inMilliseconds > 0) {
      progress = _position.inMilliseconds / _duration.inMilliseconds;
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Legenda Batu Menangis'),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: NetworkImage(
                        'https://image.popmama.com/content-images/post/20210817/untitled-1-550b58ccb974a94089a7a0f1247a90ab.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        playSound();
                      },
                      child: Text('Play'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pauseSound();
                      },
                      child: Text('Pause'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resumeSound();
                      },
                      child: Text('Resume'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        stopSound();
                      },
                      child: Text('Stop'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Volume'),
                    Slider(
                      value: _volume,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) {
                        setState(() {
                          _volume = value;
                          setVolume(value);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setPlaybackSpeed(
                            1.0); // Set kecepatan pemutaran menjadi 1x
                      },
                      child: Text('1x'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setPlaybackSpeed(
                            2.0); // Set kecepatan pemutaran menjadi 2x
                      },
                      child: Text('2x'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setPlaybackSpeed(
                            3.0); // Set kecepatan pemutaran menjadi 3x
                      },
                      child: Text('3x'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  child: Text(
                    'Legenda Batu Menangis bermula dari cerita tentang Siti Nurbaya, seorang gadis cantik di sebuah desa di Minangkabau, Sumatera Barat. Dia jatuh cinta pada Datuk Maringgih, seorang pemuda dari luar desanya. Meskipun saling mencintai, hubungan mereka terhalang oleh kemiskinan keluarga Siti Nurbaya. Ayahnya, Tuan Besar, menentang hubungan mereka dan menjodohkan Siti Nurbaya dengan seorang pria kaya. Dipaksa menikahi orang yang tidak dicintainya, Siti Nurbaya merasa terpukul dan Datuk Maringgih meninggalkan desa itu. Kesedihan mendalam merasuki hati Siti Nurbaya, dan pada suatu hari, dia meninggal karena patah hati. Makamnya yang terletak di sekitar batu-batu mulai meneteskan darah, diyakini sebagai tanda kesedihan dan penyesalan atas kepergiannya. Batu Menangis menjadi simbol penderitaan dan keadilan yang terabaikan, serta mengingatkan akan pentingnya menghargai perasaan dan kebahagiaan orang lain dalam sebuah hubungan.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> playSound() async {
    String soundPath = "audio/audio.mp3";
    await player.play(AssetSource(soundPath));
  }

  Future<void> pauseSound() async {
    await player.pause();
  }

  Future<void> resumeSound() async {
    String soundPath = "audio/audio.mp3";
    await player.play(AssetSource(soundPath));
    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
    player.onDurationChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  Future<void> stopSound() async {
    await player.stop();
  }

  Future<void> setVolume(double value) async {
    await player.setVolume(value);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await player.setPlaybackRate(speed);
    setState(() {
      _playbackSpeed = speed;
    });
  }
}