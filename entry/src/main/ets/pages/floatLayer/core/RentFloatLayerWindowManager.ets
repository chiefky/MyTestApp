import  window  from '@ohos.window'
import { common } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import display from '@ohos.display'
import {RentFloatLayerController, RentFloatLayerSlideEffect} from '../RentFloatLayerController'
import {RENT_FLOAT_LAYER_PAGE_ID} from './RentFloatLayerPage'  // 引入命名路由页面

const scale: number = display.getDefaultDisplaySync().densityPixels
const screenWidthPx: number = display.getDefaultDisplaySync().width
const screenHeightPx: number = display.getDefaultDisplaySync().height
export const screenWidth: number = screenWidthPx / scale
export const screenHeight: number = screenHeightPx / scale

export class RentFloatLayerWindowManager {
  private static DEFAULT_MASK_BG_COLOR: string = '#99000000'
  private static DEFAULT_MASK_CLEAR_COLOR: string = '#00000000'

  /**
   * 创建子窗口
   */
  public static createWindow(controller: RentFloatLayerController) {
    try {
      if (controller.option.hideMaskLayer) {
        RentFloatLayerWindowManager.createHideMaskLayerWindow(controller)
      } else {
        RentFloatLayerWindowManager.createMaskLayerWindow(controller)
      }
    } catch (exception) {
      console.error('Failed to create the window. Cause: ' + JSON.stringify(exception))
    }
  }
  /**
   * 销毁子窗口
   */
  public static destroyWindow(windowId: string) {
    let currentWindow = window.findWindow(windowId)
    currentWindow?.destroyWindow((err) => {
      if (err.code) {
        console.error('Failed to close the window. Cause: ' + JSON.stringify(err))
        return
      }
    })
  }

  private static createMaskLayerWindow(controller: RentFloatLayerController) {
    let context = getContext(controller) as common.UIAbilityContext
    let config: window.Configuration = {
      name: controller.floatWindowId,
      windowType: window.WindowType.TYPE_DIALOG,
      ctx: context
    }

    // 1.创建全屏遮罩的应用子窗口。
    window.createWindow(config, (err: BusinessError, data) => {
      const errCode: number = err.code
      if (errCode) {
        console.error('Failed to create the window. Cause: ' + JSON.stringify(err))
        return
      }
      let sub_windowClass: window.Window = data
      RentFloatLayerWindowManager.configSubWindow(sub_windowClass, controller)
    })
  }

  private static createHideMaskLayerWindow(controller: RentFloatLayerController) {
    let windowStage: window.WindowStage | undefined = controller.option.windowStage
    if (windowStage) {
      // 1.创建非全屏遮罩的应用子窗口。
      windowStage.createSubWindow(controller.floatWindowId, (err: BusinessError, data) => {
        const errCode: number = err.code
        if (errCode) {
          console.error('Failed to create the window. Cause: ' + JSON.stringify(err))
          return
        }
        let sub_windowClass: window.Window = data
        RentFloatLayerWindowManager.configSubWindow(sub_windowClass, controller)
      })
    } else {
      console.error('Failed to create hideMaskLayer window. Cause: no windowStage')
    }
  }

  private static configSubWindow(subWindow: window.Window, controller: RentFloatLayerController) {
    // 2.子窗口创建成功后，设置子窗口的位置、大小及相关属性等。
    let screenH = controller.option.hideMaskLayer?(controller.option.offset+controller.option.height)*scale:screenHeightPx
    let screenY = 0
    if (controller.option.slideEffect == RentFloatLayerSlideEffect.Bottom && controller.option.hideMaskLayer) {
      screenY = screenHeightPx - screenH
    }

    if (controller.option.hideMaskLayer) {
      // 针对非全屏遮罩场景，与全屏遮罩场景统一布局计算规则
      subWindow.setWindowLayoutFullScreen(true)
    }

    subWindow.moveWindowTo(0, screenY, (err) => {
      if (err.code) {
        console.error('Failed to move the window. Cause:' + JSON.stringify(err))
        return
      }

      subWindow.resize(screenWidthPx, screenH, (err) => {
        if (err.code) {
          console.error('Failed to change the window size. Cause:' + JSON.stringify(err))
          return
        }
      })

      // 3.为子窗口加载对应的目标页面。
      let para:Record<string, RentFloatLayerController> = {}
      para[(RentFloatLayerController.STORAGE_ID)] = controller
      let localStorage: LocalStorage = new LocalStorage(para)

      subWindow.loadContentByName(RENT_FLOAT_LAYER_PAGE_ID, localStorage, (err) => {
        if (err.code) {
          console.error('Failed to load the content. Cause:' + JSON.stringify(err))
          return
        }

        // 4.设置子窗口背景色并显示
        let bgColor: string = controller.option.maskColor?controller.option.maskColor:RentFloatLayerWindowManager.DEFAULT_MASK_BG_COLOR
        bgColor = controller.option.hideMaskLayer?RentFloatLayerWindowManager.DEFAULT_MASK_CLEAR_COLOR:bgColor
        subWindow.setWindowBackgroundColor(bgColor)
        subWindow.showWindow((err) => {
          if (err.code) {
            console.error('Failed to show the window. Cause: ' + JSON.stringify(err))
            return
          }
        })
      })
    })
  }
}