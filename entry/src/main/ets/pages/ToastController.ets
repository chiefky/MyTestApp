import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit';
import common from '@ohos.app.ability.common';


declare interface ToastControllerOptions {
  builder: CustomBuilder;
  cancel?: () => void;
  autoCancel?: boolean;
  alignment?: DialogAlignment;
  offset?: Offset;
  customStyle?: boolean;
  gridCount?: number;
  maskColor?: ResourceColor;
  maskRect?: Rectangle;
  openAnimation?: AnimateParam;
  closeAnimation?: AnimateParam;
  showInSubWindow?: boolean;
  backgroundColor?: ResourceColor;
  cornerRadius?: Dimension | BorderRadiuses;
  isModal?: boolean;
}

export class ToastController {
  builder: CustomBuilder = () => {
  }
  cancel?: () => void;
  autoCancel?: boolean;
  alignment?: DialogAlignment;
  offset?: Offset;
  customStyle?: boolean;
  gridCount?: number;
  maskColor?: ResourceColor;
  maskRect?: Rectangle;
  openAnimation?: AnimateParam;
  closeAnimation?: AnimateParam;
  showInSubWindow?: boolean;
  backgroundColor?: ResourceColor;
  cornerRadius?: Dimension | BorderRadiuses;
  isModal?: boolean;

  constructor(option: ToastControllerOptions,) {
    this.builder = option.builder;
    this.cancel = option.cancel;
    this.autoCancel = option.autoCancel;
    this.alignment = option.alignment;
    this.offset = option.offset;
    this.customStyle = option.customStyle;
    this.maskColor = option.maskColor;
    this.maskRect = option.maskRect;
    this.openAnimation = option.openAnimation;
    this.closeAnimation = option.closeAnimation;
    this.showInSubWindow = option.showInSubWindow;
    this.backgroundColor = option.backgroundColor;
    this.isModal = option.isModal;

  }





  // onWindowStageCreate(windowStage: window.WindowStage) {
  //   windowStage_ = windowStage;
  //   // 开发者可以在适当的时机，如主窗口上按钮点击事件等，创建子窗口。并不一定需要在onWindowStageCreate调用，这里仅作展示
  //   this.showSubWindow();
  // }
  //
  // onWindowStageDestroy() {
  //   // 开发者可以在适当的时机，如子窗口上点击关闭按钮等，销毁子窗口。并不一定需要在onWindowStageDestroy调用，这里仅作展示
  //   this.destroySubWindow();
  // }
}