import { window } from '@kit.ArkUI'
import util from '@ohos.util'
import { RentFloatLayerWindowManager } from './core/RentFloatLayerWindowManager'

export enum RentFloatLayerSlideEffect {
  /**
   * 浮层滑入位置：从顶部滑入屏幕
   */
  Top,
  /**
   * 浮层滑入位置：从底部滑入屏幕
   */
  Bottom
}

export interface RentFloatLayerControllerOption {
  /**
   * 自定义浮层内容构造器
   * 必传
   */
  builder: CustomBuilder
  /**
   * 浮层滑入屏幕后，距离顶部/底部的间距
   * 必传
   */
  offset: number
  /**
   * 自定义浮层的高度
   * 必传
   */
  height: number
  /**
   * 浮层滑入位置，从顶部/底部滑入屏幕
   * 非必传，默认从顶部滑入屏幕
   */
  slideEffect?: RentFloatLayerSlideEffect
  /**
   * 是否允许 mask 遮蔽全屏，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传
   * 非必传，默认 mask 遮蔽全屏
   * 注意：如果不允许 mask 遮蔽全屏，必须传入 windowStage
   */
  hideMaskLayer?: boolean
  /**
   * mask 背景颜色
   * 非必传，默认 #000000, alpha:0.6
   */
  maskColor?: string
  /**
   * 是否允许点击 mask 关闭浮层
   * 非必传，默认点击不关闭浮层
   */
  autoCancel?: boolean
  /**
   * 点击 mask 遮罩关闭浮层时的回调方法
   * 非必传
   */
  cancelOnFinish?: () => void
  /**
   * 在 mask 不遮蔽全屏的场景下，须传入 windowStage
   * hideMaskLayer = true 生效时，必传
   */
  windowStage?: window.WindowStage
}

/**
 * 带动画的底部（顶部）进入、底部（顶部）退出的弹窗/浮层
 */
export class RentFloatLayerController {
  static readonly STORAGE_ID: string = 'RENT_FLOAT_LAYER_ID'
  readonly floatWindowId: string = util.generateRandomUUID(true)
  readonly option: RentFloatLayerControllerOption = {builder:()=>{}, offset:0, height:0}

  constructor(value: RentFloatLayerControllerOption) {
    this.option = value
  }
  /**
   * 浮层滑入
   */
  open() {
    RentFloatLayerWindowManager.createWindow(this)
  }
  /**
   * 浮层滑出
   */
  close() {
    if (this.pageClose) {
      this.pageClose()
    }
  }

  private pageClose?: () => void
  setPageClose(pageClose: () => void) {
    this.pageClose = pageClose
  }
}
