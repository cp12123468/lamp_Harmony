import web_webview from '@ohos.web.webview';
import { promptAction, router } from '@kit.ArkUI';
import socket from '@ohos.net.socket';
import process from '@ohos.process';
import wifiManager from '@ohos.wifiManager';


import common from '@ohos.app.ability.common';
import StringUtils from './uint8array2string';
let tcp = socket.constructTCPSocketInstance();

//let ipAddress = wifiManager.getIpInfo().ipAddress; //真机测试
//let local_ip2 = (ipAddress>>24 &0xFF)+"."+(ipAddress>>16 &0xFF)+"."+(ipAddress>>8 &0xFF)+"."
//+(ipAddress &0xFF) //真机测试
let local_ip2 = '10.0.2.16' //用于模拟器
let tcp_on_msg = 'lampOn'



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
struct Home {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  controller: SearchController | undefined;
  changeValue: string | undefined;
  @State message: string = 'Hello World';
  @State selcetIndex : number = 0
  @State selcetIndex_1 : number = 0
  @State lampNum : number = 4
  @State OnlineNum : number = 4
  @State FaultsNum : number = 0
  @State EnergeSave : number = 70
  @State account : string = 'admin';
  //ip设置
  @State local_ip:string = local_ip2
  @State local_port:number =6666
  @State ip_addr:string ='140.246.95.197'
  @State port:number =8888
  @State send_msg:string ='send content'
  @State recv_msg:string ='lampON'


  //底部图标字体
  @Builder
  myBuilder (itemIndex : number,title : string,img : ResourceStr,seltimg : ResourceStr) {
    Column() {
      Image(itemIndex == this.selcetIndex ? seltimg : img)
        .width(30)
      Text(title)
        .fontColor(itemIndex == this.selcetIndex ? '#1296db' : Color.Black)
    }
  }

  //侧边图标字体
  @Builder
  myBuilder_one (itemIndex_1 : number,title : string,img : ResourceStr,seltimg : ResourceStr) {
    Column() {
      Image(itemIndex_1 == this.selcetIndex_1 ? seltimg : img)
        .width(30)
      Text(title)
        .fontSize(14)
        .fontColor(itemIndex_1 == this.selcetIndex_1 ? '#1296db' : Color.Black)
    }
  }

  @Builder
  myBuilder_ctrl_info (text : string){
      Row()  {
        Text(text)
          .fontSize(18)
      }
      .width('100%')
    .margin({left : 20 , bottom : 10})


  }


  build() {
    Tabs({barPosition : BarPosition.End}) {
      TabContent() {
        Column() {
          Row() {
            Image($r('app.media.link'))
              .width(25)
              .onClick(() => {
                router.pushUrl({
                  url : 'pages/linkPage'
                })
              })

            Row() {
              //顶部标题
              Text('智慧路灯控制系统')
                .fontSize(20)
                .fontStyle(FontStyle.Normal)
                .fontWeight(500)
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .padding({right : 60})

          }
          .width('100%')

          //搜索框
          Search({ value: this.changeValue, placeholder: '请输入搜索内容', controller: this.controller })
            .cancelButton({
              style: CancelButtonStyle.CONSTANT,

              icon: {

                color: Color.Red,
                src: $r('app.media.log')
              }
            })
            .width('100%')

          Scroll() {
            Column() {
              Swiper() {
                Image($r('app.media.swi_1'))
                Image($r('app.media.swi_2'))
                Image($r('app.media.swi_3'))
              }
              .width('100%')
              .height(200)
              .loop(true)
              .borderRadius(10)

              Grid() {
                //1
                GridItem(){
                  Column() {
                    Image($r('app.media.lampL'))
                      .width(40)
                    Text('故障定位')
                  }
                }
                //2
                GridItem(){
                  Column() {
                    Image($r('app.media.oneKeyRepair'))
                      .width(40)
                    Text('一键报修')
                  }
                }

                GridItem(){
                  Column() {
                    Image($r('app.media.energyConsStats'))
                      .width(40)
                    Text('能耗统计')
                  }
                }

                GridItem(){
                  Column() {
                    Image($r('app.media.realTimeShow'))
                      .width(40)
                    Text('实时能耗')
                  }
                }

                GridItem(){
                  Column() {
                    Image($r('app.media.groupManage'))
                      .width(40)
                    Text('分组管理')
                  }
                }

                GridItem(){
                  Column() {
                    Image($r('app.media.autoCtrl'))
                      .width(40)
                    Text('自动化控制')
                  }
                }

                GridItem(){
                  Column() {
                    Image($r('app.media.modeSwitch'))
                      .width(40)
                    Text('模式切换')
                  }
                }

                GridItem(){
                  Column() {
                    Image($r('app.media.lampFaults'))
                      .width(40)
                    Text('问题上报')
                  }
                }
              }
              .height(150)
              .rowsTemplate('1fr 1fr')
              .columnsTemplate('1fr 1fr 1fr 1fr')

              //集群一
              Row() {
                Text('测试')
                  .fontSize(25)
                  .fontStyle(FontStyle.Normal)
                  .fontWeight(500)
                  .padding({left : 20,top : 20})

                Row() {
                  Text('运行状态')
                    .fontSize(18)
                  Image($r('app.media.normalRun'))
                    .width(20)

                }

                Row() {
                  Text('快速开关')
                  Toggle({type: ToggleType.Switch,isOn : false})
                    .margin({right : 20})
                    .onChange((isOn: boolean) => {
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
                        this.recv_msg = 'Lamp ON,IP:'+this.ip_addr
                      }
                      )
                      tcp.send({
                        data: this.recv_msg
                      }
                        , err => {
                          if (err) {
                            console.log('send fail');
                            this.recv_msg='send fail_remote'
                            return;
                          }
                          tcp.close();
                          console.log('send success');
                          this.recv_msg='send success_remote';
                        })
                      tcp.on('message', value => {
                        console.log("on message, message:" + value.message + ", remoteInfo:" + value.remoteInfo)
                        this.recv_msg = this.recv_msg+StringUtils.arrayBuffer2String(value.message);

                      });


                    })

                }

              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Web({ src: $rawfile("web.html"), controller: this.webviewController })
              }
              .width('100%')
              .height(150)
              .backgroundColor(Color.Pink)
              .borderRadius(10)

              //集群二
              Row() {
                Text('操场')
                  .fontSize(25)
                  .fontStyle(FontStyle.Normal)
                  .fontWeight(500)
                  .padding({left : 20,top : 20})

                Row() {
                  Text('快速开关')
                  Toggle({type: ToggleType.Switch})
                    .margin({right : 20})
                }

              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Web({ src: $rawfile("web.html"), controller: this.webviewController })
              }
              .width('100%')
              .height(150)
              .backgroundColor(Color.Pink)
              .borderRadius(10)

              //集群三
              Row() {
                Text('南京路')
                  .fontSize(25)
                  .fontStyle(FontStyle.Normal)
                  .fontWeight(500)
                  .padding({left : 20,top : 20})

                Row() {
                  Text('快速开关')
                  Toggle({type: ToggleType.Switch})
                    .margin({right : 20})

                }

              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Web({ src: $rawfile("web.html"), controller: this.webviewController })
              }
              .width('100%')
              .height(150)
              .backgroundColor(Color.Pink)
              .borderRadius(10)

            }
            .alignItems(HorizontalAlign.Start)

        }
          .width('100%')
          .height(650)
          .scrollable(ScrollDirection.Vertical)

        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .height('100%')

      }
      .tabBar(this.myBuilder(0,'首页',$r('app.media.home'),$r('app.media.home_1')))

      TabContent() {
        Column() {
          Row() {
            Text('控制中心')
              .fontSize(20)
              .fontStyle(FontStyle.Normal)
              .fontWeight(500)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .margin({bottom : 20})


          List({space : 20}) {
            ListItemGroup({header :this.myBuilder_ctrl_info('数据监控与统计模块')}){
              ListItem(){
                Grid() {
                  GridItem() {
                    Column() {
                      Image($r('app.media.carFlow'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('车流量显示')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.personFlow'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('人流量显示')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.linghtIntAndWeather'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('光照及天气')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.lampRecord'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('路灯运行记录')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.repairRecord'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('故障记录')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.fixLog'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('修复日志')
                    }
                  }


                }
                .columnsTemplate('1fr 1fr 1fr')
                .rowsTemplate('1fr 1fr')
                .width('100%')
                .height(150)
              }
            }

            ListItemGroup({header :this.myBuilder_ctrl_info('自动化规则模块')}){
              ListItem(){
                Grid() {
                  GridItem() {
                    Column() {
                      Image($r('app.media.autoRule'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('创建自动化规则')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.presetRule'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('预设规则选择')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.user_management'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('用户自定义规则')
                    }
                  }
                }
                .columnsTemplate('1fr 1fr 1fr')
                .width('100%')
              }
            }

            ListItemGroup({header :this.myBuilder_ctrl_info('数据监控与统计模块')}){
              ListItem(){
                Grid() {
                  GridItem() {
                    Column() {
                      Image($r('app.media.carFlow'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('车流量显示')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.personFlow'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('人流量显示')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.linghtIntAndWeather'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('光照及天气')
                    }
                  }
                }
                .columnsTemplate('1fr 1fr 1fr')
                .width('100%')
              }
            }

            ListItemGroup({header :this.myBuilder_ctrl_info('系统设置模块')}){
              ListItem(){
                Grid() {
                  GridItem() {
                    Column() {
                      Image($r('app.media.userAuthManage'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('用户权限管理')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.personFlow'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('管理员权限')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.orpAuth'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('操作员权限')
                    }
                  }
                }
                .columnsTemplate('1fr 1fr 1fr')
                .width('100%')
              }
            }

            ListItemGroup({header :this.myBuilder_ctrl_info('通知管理')}){
              ListItem(){
                Grid() {
                  GridItem() {
                    Column() {
                      Image($r('app.media.alarmInfo'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('推送报警信息')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.statusChangeRemind'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('状态变更提醒')
                    }
                  }

                }
                .columnsTemplate('1fr 1fr 1fr')
                .width('100%')
              }
            }

            ListItemGroup({header :this.myBuilder_ctrl_info('路灯信息查询')}){
              ListItem(){
                Grid() {
                  GridItem() {
                    Column() {
                      Image($r('app.media.lampFaults'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('路灯信息查询')
                    }
                  }

                  GridItem() {
                    Column() {
                      Image($r('app.media.lampLocation'))
                        .width(40)
                        .margin({bottom : 3})
                      Text('路灯定位')
                    }
                  }

                }
                .columnsTemplate('1fr 1fr 1fr')
                .width('100%')
              }
            }

          }
          .backgroundColor(Color.White)
          .divider({
            strokeWidth: 1,
            startMargin: 60,
            endMargin: 10,
            color: '#ffe9f0f0'
          })
          .borderRadius(15)

        }
        .width('100%')
        .height('100%')

      }.tabBar(this.myBuilder(1,'控制',$r('app.media.contorl'),$r('app.media.contorl_1')))

      TabContent() {
        Column() {
          Row() {
            //顶部标题
            Text('消息')
              .fontSize(20)
              .fontStyle(FontStyle.Normal)
              .fontWeight(500)

          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .height('100%')
        .backgroundColor('#f0f2f4')

      }
      .tabBar(this.myBuilder(2,'消息',$r('app.media.mage'),$r('app.media.mage_1')))

      TabContent() {
        Column({space : 10}) {
          Row() {
            Text('我的')
              .fontSize(20)
              .fontStyle(FontStyle.Normal)
              .fontWeight(500)

          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          Row() {
            Row() {
              Image($r('app.media.userInfo'))
                .width(30)

              Column() {
                Text('陈璞')
                Text('账号:' + this.account )
              }

            }
          }
          .backgroundColor(Color.White)
          .width('100%')
          .height(100)
          .justifyContent(FlexAlign.Center)
          .borderRadius(15)
          List({space : 15}) {
            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.pushManage'))
                    .margin({
                      right : 5
                    })
                    .width(30)
                  Text('推送管理')
                }
                Image($r('app.media.enterIn'))
                  .width(14)

              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.repairRecord'))
                    .width(30)
                    .margin({
                      right : 5
                    })
                  Text('维修记录')
                }

                Image($r('app.media.enterIn'))
                  .width(14)

              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.personMage'))
                    .width(30)
                    .margin({
                      right : 5
                    })
                  Text('个人信息管理')
                }

                Image($r('app.media.enterIn'))
                  .width(14)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.rightManagement'))
                    .width(30)
                    .margin({
                      right : 5
                    })
                  Text('账号与安全设置')
                }

                Image($r('app.media.enterIn'))
                  .width(14)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.helpAndFeedback'))
                    .width(30)
                    .margin({
                      right : 5
                    })
                  Text('帮助与反馈')
                }

                Image($r('app.media.enterIn'))
                  .width(14)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }

            ListItem() {
              Row() {
                Row() {
                  Image($r('app.media.about'))
                    .width(30)
                    .margin({
                      right : 5
                    })
                  Text('关于我们')
                }

                Image($r('app.media.enterIn'))
                  .width(14)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
          }
            .backgroundColor(Color.White)
            .divider({
              strokeWidth: 1,
              startMargin: 60,
              endMargin: 10,
              color: '#ffe9f0f0'
            })
          .borderRadius(15)
          Blank()
          Button('退出登录', { type: ButtonType.Capsule })
            .width('100%')
            .height(40)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 20 })
            .onClick(() => {
              promptAction.showToast({ message: '退出登录' })
              router.replaceUrl({ url: 'pages/loginPage' })
            })

        }
        .backgroundColor('#f0f2f4')
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .height('100%')



      }
      .tabBar(this.myBuilder(3,'我的',$r('app.media.I'),$r('app.media.I_1')))
    }
    .scrollable(false)
    .animationDuration(0)
    .onTabBarClick((index : number) => {
      this.selcetIndex = index
    })
  }
}