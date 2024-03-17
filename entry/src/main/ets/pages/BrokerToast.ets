// xxx.ets
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct AlertPage {
 @State isShow:boolean = false
  @State textValue: string = ''
  @State inputValue: string = 'click me'

@Builder alertBuilder(){
  Column(){
    // Text("Hello").width('90').height(40)
    BrokerToast().width('90').height(100)
  }
}

  onCancel(){

  }
  onAccept(){

  }

  build() {
    Column({ space: 10 }) {
     Text('Hello World!').width('90%').height(40)
      if (this.isShow) {
        this.alertBuilder()
      }

    }
    .backgroundColor('#ffdb8383')
    .width('100%').height('100%')
  }

}

@Component
export default struct BrokerToast {
  // @Link textValue: string
  // @Link inputValue: string
  // controller: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在最后
  // cancel: () => void = ()=>{}
  // confirm: () => void =()=>{}


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
          // this.cancel()
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

    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
  }
}
