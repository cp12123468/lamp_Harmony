import socket from '@ohos.net.socket';
import process from '@ohos.process';
import wifiManager from '@ohos.wifiManager';


import common from '@ohos.app.ability.common';
import StringUtils from './uint8array2string';
//import StringUtils2 from '../http2/uint8array2string_test'

let tcp = socket.constructTCPSocketInstance();

//let ipAddress = wifiManager.getIpInfo().ipAddress; //真机测试
//let local_ip2 = (ipAddress>>24 &0xFF)+"."+(ipAddress>>16 &0xFF)+"."+(ipAddress>>8 &0xFF)+"."
//+(ipAddress &0xFF) //真机测试
let local_ip2 = '10.0.2.16' //用于模拟器，真机则屏蔽此处
let tcp_on_msg = ''


interface GeneratedObjectLiteralInterface_1 {
  address: string;
  port: number;
  family: number;
}

interface GeneratedObjectLiteralInterface_2 {
  address: string;
  port: number;
  family: number;
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  @State local_ip:string = local_ip2
  @State local_port:number =6666
  @State ip_addr:string ='140.246.95.197'
  @State port:number =8888
  @State send_msg:string ='send content'
  @State recv_msg:string =''

  build() {


    Column() {
      Row(){
        Text(' ')
      }
      Row(){
        Text('智光Harmony设备连接')
          .fontSize(30)
          .fontColor(Color.White)
          .backgroundColor(Color.Blue)
      }
      Row(){
        Text('本机IP:').fontSize(28)
          .backgroundColor(Color.Green)
        TextInput({text:`${this.local_ip}`})
          .fontSize(28)
          .width(280)
          .backgroundColor(Color.Transparent)
          .onChange((value:string)=>{
            this.local_ip = value
          })

      }
      Row(){
        Text('端口:').fontSize(28)
          .backgroundColor(Color.Green)
        TextInput({text:`${this.local_port}`})
          .fontSize(28)
          .width(280)
          .backgroundColor(Color.Transparent)
          .onChange((value:string)=>{
            this.local_port = parseInt(value, 10); //字符转数字
          })

      }
      Row(){
        Text('服务器IP:').fontSize(28)
          .backgroundColor(Color.Green)
        TextInput({text:`${this.ip_addr}`})
          .fontSize(28)
          .width(280)
          .backgroundColor(Color.Transparent)
          .onChange((value:string)=>{
            this.ip_addr = value
          })

      }
      Row(){
        Text('端口:').fontSize(28)
          .backgroundColor(Color.Green)
        TextInput({text:`${this.port}`})
          .fontSize(28)
          .width(280)
          .backgroundColor(Color.Transparent)
          .onChange((value:string)=>{
            this.port = parseInt(value, 10); //字符转数字
          })

      }
      Row(){
        Text('发送:').fontSize(28)

      }.align(Alignment.Start)
      Row(){
        TextArea({text:`${this.send_msg}`})
          .fontSize(28)
          .height(100)
          .onChange((value:string)=>{
            this.send_msg = value
          })
      }
      Row(){
        Text('接收:').fontSize(28)

      }.align(Alignment.Start)
      Row(){
        TextArea({text:`${this.recv_msg}`})
          .fontSize(28) //文本自动换行
          .height(200)
          .onChange((value:string)=>{
            this.recv_msg = value
          })

      }
      Row()
      {
        Button('连接')
          .width(100)
          .fontSize(28)
          .onClick(() => {
            // 绑定IP地址和端口。//连接服务器，必须首先绑定本机IP

            let bindAddress: GeneratedObjectLiteralInterface_1 = {
              address: this.local_ip,
              port: this.local_port, // 绑定端口，如1234
              family: 1
            };
            tcp.bind(bindAddress, err => {
              if (err) {
                console.log('bind fail_local');
                this.recv_msg = 'connect fail_local,IP:'+this.local_ip
                return;
              }
              console.log('bind success_local');
              this.recv_msg = 'connect fail_local,IP:'+this.local_ip
            })

            let connectAddress: GeneratedObjectLiteralInterface_2 = {
              address: this.ip_addr,
              port: this.port, // 连接端口，如5678
              family: 1
            };
            tcp.connect({
              address: connectAddress, timeout: 3000
            },err=>{
              if (err) {
                console.log('connect fail_remote');
                this.recv_msg = 'connect fail_remote,IP:'+this.ip_addr

                return;
              }
              console.log('connect success');
              this.recv_msg = 'connect success_remote,IP:'+this.ip_addr
            }
            )
            tcp.on('message', value => {
              console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo)
              this.recv_msg = this.recv_msg+StringUtils.arrayBuffer2String(value.message);

            });

          })
        Button('______').onClick((event: ClickEvent) => {
        })
        Button('发送')
          .width(100)
          .fontSize(28)
          .onClick((event: ClickEvent) => {
            tcp.send({
              data: this.send_msg
            }, err => {
              if (err) {
                console.log('send fail');
                this.recv_msg='send fail_remote'
                return;
              }
              tcp.close();
              console.log('send success');
              this.recv_msg='send success_remote';
            })
          })

      }
      Row(){
        Button('退出')
          .width(100)
          .fontSize(28)
          .onClick((event: ClickEvent) => {
              tcp.close();
            const context = getContext(this) as common.UIAbilityContext;
            context.terminateSelf();
            let applicationContext = context.getApplicationContext();
            // applicationContext.killProcessesBySelf().
            // then((data)=>
            // {console.log('The process running information is:'+ JSON.stringify(data));})
            //   .catch((error)=>{console.error('error:'+ JSON.stringify(error));})
            // process.kill(0, process.pid)
            // process.exit(0)
          })
      }


    }
    .width('100%')
    .padding(20) //边距
    .backgroundColor('#ffe9f0f0')

  }
}