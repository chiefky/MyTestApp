import { MyAlertComponent } from "../MyAlertComponent";
import { window } from '@kit.ArkUI';
import { MyDialogController } from '../Encapsulation/DialogEmptyPage';

@Entry
@Component
struct EmptyPage {
  @State widthSize: number = 100
  @State heightSize: number = 100
  @State isShow: boolean = false

  @Builder
  subviewsBuilder() {
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
          this.close()
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
    // 组件添加时从底部滑出，透明度从0到1.0
    .transition({ type: TransitionType.Insert, translate: { x: 0, y: -500, z: 0 }, opacity: 1.0 })
    // 组件移除从底部滑出，透明度从1.0到0
    .transition({ type: TransitionType.Delete, translate: { x: 100, y: -500, z: 0 }, opacity: 1.0 })
  }

  @Builder
  myAlert() {
    MyAlertComponent().width(100).height(60)
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        if (this.isShow) {
          this.subviewsBuilder()
        }

        // Button('显示/隐藏').width(100).height(40).onClick(() => {
        //  animateTo({duration:600},()=>{
        //    this.isShow = !this.isShow
        //  })
        // })
      }.width('100%').height(200)

      // Stack({ alignContent: Alignment.Top }) {
      //   if (this.isShow) {
      //     this.subviewsBuilder()
      //   }
      // }

    }
    .backgroundColor('#889234')
    .width('100%').height('100%')
  }

  onPageShow() {
    animateTo({ duration: 600 }, () => {
      this.isShow = !this.isShow
    })
  }

  // onPageHide(): void {
  //   animateTo({ duration: 600 }, () => {
  //     this.isShow = !this.isShow
  //   })
  // }

  close() {
    animateTo({
      duration: 600,
      onFinish: () => {
        this.destroyWindow()
    } }, () => {
      this.isShow = false
    })

    // animateTo({
    //   duration: 600, delay: 600, onFinish: () => {
    //     /*动画结束后，销毁window*/
    //     let currentWindow = window.findWindow("MyAlertWindow")
    //     currentWindow?.destroyWindow((err) => {
    //       if (err.code) {
    //         console.error('Failed to close the window. Cause: ' + JSON.stringify(err));
    //         return;
    //       }
    //       console.info('Succeeded in closing the window.');
    //     })
    //   }
    //
    // }, () => {
    //   /*执行动画隐藏内容*/
    //   // animateTo({ duration: 600 }, () => {
    //   //   this.isShow = !this.isShow
    //   // })
    // })
  }

  destroyWindow(){
    /*动画结束后，销毁window*/
        let currentWindow = window.findWindow("MyAlertWindow")
    currentWindow?.destroyWindow((err) => {
      if (err.code) {
        console.error('Failed to close the window. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in closing the window.');
    })
  }
}