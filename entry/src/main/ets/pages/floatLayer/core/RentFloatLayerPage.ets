import { RentFloatLayerController, RentFloatLayerSlideEffect } from "../RentFloatLayerController"
import { RentFloatLayerWindowManager, screenHeight } from './RentFloatLayerWindowManager'

export const RENT_FLOAT_LAYER_PAGE_ID: string = 'RENT_FLOAT_LAYER_PAGE_ID'

@Component
struct RentFloatLayerPageContent {
  @BuilderParam subView?: () => void
  private slideEffect: RentFloatLayerSlideEffect = RentFloatLayerSlideEffect.Top
  private windowHeight: number = 0

  build() {
    Row() {
      if (this.subView) {
        this.subView()
      }
    }
    .transition({
      type: TransitionType.Insert,
      translate: { x:0, y:this.slideEffect==RentFloatLayerSlideEffect.Top?-200:this.windowHeight+200, z:0 },
      opacity: 1.0 })
    .transition({
      type: TransitionType.Delete,
      translate: { x:0, y:this.slideEffect==RentFloatLayerSlideEffect.Top?-200:this.windowHeight+200, z:0 },
      opacity: 0 })
    .width('100%').height("100%")
    .justifyContent(FlexAlign.Center)
  }
}

@Entry({ routeName: RENT_FLOAT_LAYER_PAGE_ID })
@Component
export struct RentFloatLayerPage {
  @State heightSize: number = 0
  @State topMargin: number = 0
  @State isShow: boolean = false
  @BuilderParam child?: () => void
  private controller?: RentFloatLayerController = undefined

  aboutToAppear(): void {
    let storage = LocalStorage.getShared()
    this.controller = storage.get(RentFloatLayerController.STORAGE_ID)

    if (this.controller) {
      if (typeof this.controller?.option.builder === 'function') {
        this.child = this.controller.option.builder
      }
      this.controller.setPageClose(()=>{this.closePage()})
      this.heightSize = this.controller.option.height

      let margin = this.controller.option.offset
      this.topMargin = this.controller.option.slideEffect==RentFloatLayerSlideEffect.Top?margin:screenHeight-this.heightSize-margin
      // 非全屏遮罩的底部弹窗需要特殊处理
      if (this.controller.option.hideMaskLayer && this.controller.option.slideEffect == RentFloatLayerSlideEffect.Bottom) {
        this.topMargin = 0
      }
    }
  }

  build() {
    Column() {
      if (this.isShow) {
        RentFloatLayerPageContent({
          subView: this.child,
          slideEffect: this.controller?this.controller?.option.slideEffect:RentFloatLayerSlideEffect.Top,
          windowHeight: this.controller?.option.hideMaskLayer?(this.controller.option.offset+this.controller.option.height):screenHeight
        })
          .margin({top:this.topMargin})
          .width('100%').height(this.heightSize)
          // 屏蔽容器组件区域的响应事件
          .onClick(()=>{})
      }
    }
    .width('100%').height('100%')
    .onClick(()=>{
      if (this.controller && this.controller.option.autoCancel) {
        this.closePage()
        if (this.controller.option.cancelOnFinish) {
          this.controller.option.cancelOnFinish()
        }
      }
    })
  }

  onPageShow(): void {
    animateTo({ duration: 300 }, () => {
      this.isShow = true
    })
  }

  closePage() {
    animateTo({ duration: 300, onFinish: () => {
      RentFloatLayerWindowManager.destroyWindow(this.controller?.floatWindowId)
    }}, () => {
      this.isShow = false
    })
  }
}