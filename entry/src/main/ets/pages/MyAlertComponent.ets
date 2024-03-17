import BrokerToast from './BrokerToast'

@Component
export struct MyAlertComponent {
  @State textValue: string = ''
  @State inputValue: string = 'click me'
  onCancel:()=>void = ()=>{}

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Row({ space: 5 }) {
      Image($r('app.media.broker')).width(60).height(60)
      Column() {
        Text('您浏览的房源有优惠').fontSize(16).fontWeight(500)
        Text('现在「新龙城小区」房源有折扣优惠价，我给您介绍下').fontSize(13)
      }.width('50%').height(60).justifyContent(FlexAlign.SpaceAround)

      // .backgroundColor('#bb6762')
      Text('去咨询')
        .fontSize(12)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          // this.controller.close()
          this.onCancel()
        })
        .borderRadius(4)
        .width(60)
        .height(30)
        .backgroundColor('#ff090626')
        .fontColor(Color.White)

    }
    // .backgroundColor('#fff445')
    .padding({ top: 10, bottom: 10 })
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height('100%')
    // 组件添加时从底部滑出，透明度从0到1.0
    .transition({ type: TransitionType.Insert, translate: { x: 0, y: -500, z: 0 }, opacity: 1.0 })
    // 组件移除从底部滑出，透明度从1.0到0
    .transition({ type: TransitionType.Delete, translate: { x: 0, y: -500, z: 0 }, opacity: 0 })

  }
}

