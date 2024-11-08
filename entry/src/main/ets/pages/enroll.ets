import { font } from '@kit.ArkUI';

@Entry
@Component
struct Enroll {
  @State message: string = 'Hello World';

  build() {
    Column() {
      //顶部组件
      Row(){
        Image($r('app.media.returnTop'))
          .width(18)
          //.margin({ left : 10 , right :10})

        Text('注 册')
          .fontSize(20)
          .fontStyle(FontStyle.Normal)
          .margin({right : 3})

        Text('1')
          .fontColor(Color.White)


      }
      .backgroundColor(Color.White)
      .padding({left : 10 , right : 10})
      .width('100%')
      .height(40)
      .justifyContent(FlexAlign.SpaceBetween)

      Column({space :20}) {
        //注册输入框
        TextInput({placeholder : '    请输入注册账号'})
        TextInput({placeholder : '    请输入注册密码'})
        TextInput({placeholder : '    请再次输入注册密码'})
        TextInput({placeholder : '    请输入手机号'})
        TextInput({placeholder : '    请输入注册账号类型'})
        TextInput({placeholder : '    验证码'})
      }
      .padding({
        top : 70,
      })


      //注册按钮
      Button('注册')
        .width('100%')
        .margin({
          top : 40
        })

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#ccc')


  }
}