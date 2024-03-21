import { RentFloatLayerController, RentFloatLayerSlideEffect} from './floatLayer/RentFloatLayerController';
import BrokerToast from './BrokerToast';
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  private maskController: RentFloatLayerController = new RentFloatLayerController({
    builder:(()=>{this.myMaskAlert()}),
    offset:50,
    height:100,
    slideEffect:RentFloatLayerSlideEffect.Bottom,
    autoCancel:true,
    cancelOnFinish:(()=>{this.cancelComplete()}),
  })

  private hideMaskController?: RentFloatLayerController
  aboutToAppear(): void {
    let storage = LocalStorage.getShared()
    let windowStage: window.WindowStage|undefined = storage.get('windowStage')
    this.hideMaskController = new RentFloatLayerController({
      builder:(()=>{this.myHideMaskAlert()}),
      offset:50,
      height:100,
      slideEffect:RentFloatLayerSlideEffect.Bottom,
      hideMaskLayer:true,
      windowStage:windowStage
    })
  }

  cancelComplete() {
    console.log("❀：哈哈哈，大猪头~~~~")
  }
  maskControllerCancel() {
    this.maskController.close()
  }

  hideMaskControllerCancel() {
    this.hideMaskController?.close()
  }

  @Builder
  myMaskAlert() {
    BrokerToast({
      cancel: (()=>{this.maskControllerCancel()})
    })
  }

  @Builder
  myHideMaskAlert() {
    BrokerToast({
      cancel: (()=>{this.hideMaskControllerCancel()})
    })
  }

  build() {
    Row() {
      Column({space:10}) {
        /*创建全遮罩的显示弹窗*/
        Column() {
          Text("创建全遮罩的显示弹窗").margin({ top: 20 }).width('100%').textAlign(TextAlign.Center)
          Button('加载RentFloatLayerPage')
            .width('100%')
            .height(40)
            .onClick(() => {
              this.maskController.open()
            })
        }.width('90%')

        /*创建无遮罩的显示弹窗*/
        Column() {
          Text("创建无遮罩的显示弹窗").margin({ top: 20 }).width('100%').textAlign(TextAlign.Center)
          Button('加载RentFloatLayerPage')
            .width('100%')
            .height(40)
            .onClick(() => {
              this.hideMaskController?.open()
            })
        }.width('90%')
      }
      .width('100%')
    }
    .height('100%')
  }
}