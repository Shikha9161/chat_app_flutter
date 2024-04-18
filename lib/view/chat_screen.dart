import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/models/msg_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var msgList=<MsgData>[].obs;

  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  final TextEditingController _controller = TextEditingController();




  readMsg(){
    channel.stream.listen(
          (message) {
            var now = DateTime.now();
            var time = DateFormat('h:mm a').format(now); // 'h:mm a' for AM/PM format
            msgList.add(MsgData( msg: '$message', time: '$time'));
            print('Received: $message  ');
        // Handle the incoming message here, e.g., update UI or process data
      },
      onDone: () {
        print('WebSocket channel closed');
      },
      onError: (error) {
        print('Error in WebSocket channel: $error');
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readMsg();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat Screen",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Obx(
                ()=> ListView.builder(
                  itemCount: msgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(msgList[index].msg),
                      subtitle: Text(
                        msgList[index].time,
                      ),
                    );
                  },
                ),
              )
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  channel.sink.add(_controller.text);


                  _controller.clear();
                }
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}