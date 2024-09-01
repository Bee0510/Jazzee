// ignore_for_file: prefer_const_constructors

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:jazzee/components/basic_text.dart';
import 'package:jazzee/components/button.dart';
import 'package:jazzee/components/text_field.dart';
import 'package:jazzee/constants.dart/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/theme/base_color.dart';
import '../../main.dart';

class videoCallScreen extends StatefulWidget {
  const videoCallScreen({super.key});

  @override
  State<videoCallScreen> createState() => _videoCallScreenState();
}

class _videoCallScreenState extends State<videoCallScreen> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRoleType _role = ClientRoleType.clientRoleBroadcaster;
  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
        title: basic_text(
            title: 'Interview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Center(child: Image.network('https://tinyurl.com/2p889y4k')),
          SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: text_box(
          //     value: _channelController,
          //     title: '',
          //     hint: 'Channel name',
          //     validator: (value) {
          //       if (value!.isEmpty) {
          //         return 'Channel name is required';
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          Text(
            'Channel Name: $channel',
            style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          // RadioListTile(
          //   title: Text('Broadcaster'),
          //   value: ClientRoleType.clientRoleBroadcaster,
          //   groupValue: _role,
          //   onChanged: (value) {
          //     setState(() {
          //       _role = ClientRoleType.clientRoleBroadcaster;
          //     });
          //   },
          // ),
          SizedBox(height: 20),
          Button(
              onPressed: onJoin,
              color: AppColors.black,
              text: 'Join',
              minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 60)),
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    await [Permission.camera, Permission.microphone].request();
    navigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => videoCall(),
    ));
  }
}

class videoCall extends StatefulWidget {
  const videoCall({Key? key}) : super(key: key);

  @override
  State<videoCall> createState() => _videoCallState();
}

class _videoCallState extends State<videoCall> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool _muted = false;

  @override
  void initState() {
    _remoteUid = 0;
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _onEndCall() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController.remote(
                          connection: const RtcConnection(channelId: channel),
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: _onToggleMute,
                    shape: const CircleBorder(),
                    fillColor: _muted ? Colors.redAccent : Colors.blueAccent,
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      _muted ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: _onEndCall,
                    shape: const CircleBorder(),
                    fillColor: Colors.red,
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: _onSwitchCamera,
                    shape: const CircleBorder(),
                    fillColor: Colors.blueAccent,
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(
                      Icons.switch_camera,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for user to join',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      );
    }
  }
}

class CallPage extends StatefulWidget {
  const CallPage({super.key, required this.channelName, required this.role});
  final String channelName;
  final ClientRoleType role;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  late String channelName;
  final _infoStrings = <String>[];
  bool muted = false;
  late RtcEngine _engine;
  bool viewPanel = false;
  bool _localUserJoined = false;
  int? _remoteUid;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add('AppId Missing, please provide your APP_ID');
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _addAgoraEventHandler();
    await _engine.setClientRole(role: widget.role);
    await _engine.setVideoEncoderConfiguration(
      VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1920, height: 1080),
      ),
    );
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  void _addAgoraEventHandler() {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onFirstRemoteVideoFrame:
            (connection, remoteUid, width, height, elapsed) {
          setState(() {
            _infoStrings
                .add('First Remote video: $remoteUid ${widget}X $height');
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
  }

  // Widget _viewRow() {
  //   final List<StatefulWidget> list = [];
  //   if (widget.role == ClientRoleType.clientRoleBroadcaster) {
  //     list.add();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      );
    }
  }
}

const channel = 'Jazzee';
