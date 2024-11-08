import Echarts from './Echarts'

@Entry
@Component
struct Index {
  //图表配置
  @State option: string = ``
  //x轴数据
  @State xAxisData: string[] = [];
  //y轴数据
  @State seriesData: number[] = [];
  myEchart: Echarts | null = null;
  @State option_1: string = ``
  myEchart_1: Echarts | null = null;
  aboutToAppear(): void {
    this.getData()
  }

  /*
   * 设置配置并重新渲染
   */
  setOption() {
    this.option = `{
    title: {
      text: '路灯功率折线图'
    },
    grid:{
      left:"15%"
    },
    legend:{
      data: ['瓦特（W）']
    },
    xAxis: {
      type: 'category',
      data: ${JSON.stringify(this.xAxisData)}
    },
    yAxis: {
      axisLabel: {
        show: true,
        formatter:(value, index)=> {
            return value + 'W';
        }
      }
    },
    series: [
      {
        data: ${JSON.stringify(this.seriesData)},
        type: 'line',
        name:'瓦特（W）'
      }
    ]
  }`
    this.myEchart?.render(this.option)
  }

  /*
 * 设置配置并重新渲染
 */
  setOption_1() {
    this.option_1 = `{
    title: {
      text: '基础柱状图'
    },
    grid:{
      left:"15%"
    },
    legend:{
      data: ['访问量']
    },
    xAxis: {
      type: 'category',
      data: ${JSON.stringify(this.xAxisData)}
    },
    yAxis: {
      axisLabel: {
        show: true,
        formatter:(value, index)=> {
            return value + '万';
        }
      }
    },
    series: [
      {
        data: ${JSON.stringify(this.seriesData)},
        type: 'bar',
        name:'访问量'
      }
    ]
  }`
    this.myEchart_1?.render(this.option_1)
  }

  //接口请求获取数据
  getData() {
    //模拟接口请求
    setTimeout(() => {
      this.xAxisData = ['18:00', '20:00', '22:00', '24:00', '02:00', '04:00', '06:00']
      this.seriesData = [120, 200, 150, 80, 70, 110, 130]
      this.setOption()
    }, 2000)
  }

  getData_1() {
    //模拟接口请求
    setTimeout(() => {
      this.xAxisData = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      this.seriesData = [120, 200, 150, 80, 70, 110, 130]
      this.setOption_1()
    }, 2000)
  }

  // 组件实例
  chart?: Echarts;

  build() {
    Column() {
      Echarts({
        eHeight: 300,
        renderCallBack: (e: Echarts) => {
          this.myEchart = e
          this.setOption()
        }
      })


    }
    .width('100%')
    .height('100%')
  }
}
