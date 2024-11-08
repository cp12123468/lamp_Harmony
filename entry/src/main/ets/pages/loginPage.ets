import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
  @State password: string = '';
  @State account: string = '';
  @State message: string = 'Hello World';
  //是否显示加载条
  @State isShowProgress: boolean = false;
  //超时标识
  private timeOutId: number = -1;

  /**
   * 登录
   */
  login(): void {
    if (this.account === '' || this.password === '') {
      //显示Toast
      promptAction.showToast({ message: '账号或密码为空' })
      return
    }
    if (this.account === 'admin' && this.password === '123123') {
      //显示Toast
      promptAction.showToast({ message: '登录成功' })
      if (this.timeOutId === -1) {
        //设置超时处理，两秒后执行页面跳转到主页
        this.timeOutId = setTimeout(() => {
          this.isShowProgress = false;
          this.timeOutId = -1;
          router.replaceUrl({ url: 'pages/home' });
        }, 2000);
      }

      return
    }
    promptAction.showToast({ message: '账号密码错误' })
  }

  build() {

    Column({space : 20}) {
      Image($r('app.media.im_1'))
        .width('100%')
      TextInput({
        placeholder : '请输入用户名'
      }).type(InputType.Normal)
        .onChange((value: string) => {
          //获取输入的内容
          this.account = value;
        })
      TextInput({
        placeholder : '请输入密码'
      }).type(InputType.Password)
        .onChange((value: string) => {
          //获取密码的内容
          this.password = value;
        })
      Button('登录')
        .width('100%')
        .onClick(() => {
          this.login()
        })
      Row({space : 12}) {
        Text('注册账号')
          .onClick(() => {
            router.pushUrl({
              url : 'pages/enroll'
            })
          })
        Text('忘记密码')
          .onClick(() => {
            router.pushUrl({
              url : 'pages/Index'
            })
          })
        //是否显示等待进度条
        if (this.isShowProgress) {
          LoadingProgress()
            .color($r('app.color.start_window_background'))
            .width(30)
            .height(30)
            .margin({ top: 20 })
        }

      }
    }.width('100%')
    .padding({
      left : 20,
      right :20,
    })
  }
}