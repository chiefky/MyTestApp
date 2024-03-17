import { MyAlertComponent } from "../MyAlertComponent";
import { Position, window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import display from '@ohos.display'
@Entry
@Component
struct DialogEmptyPage {
  @State widthSize: number = 100
  @State heightSize: number = 100
  @State isShow: boolean = false

  controller?: MyDialogController = undefined
  @BuilderParam child?: () => void;

  aboutToAppear(): void {
    let storage = LocalStorage.getShared();
    this.controller = storage.get('MyDialogController');

    if (this.controller != undefined) {

      if (typeof this.controller?.builder === 'function') {
        this.child = this.controller.builder;
      }
      this.controller.pageClose = this.closePage.bind(this)
    }
  }

  build() {
    Column() {
      if (this.isShow) {
        if (typeof this.child === 'function') {
          this.child()
        }
      }
    }
    .backgroundColor('#008a8787')
    .width('100%').height('100%')
  }

  onPageShow(): void {
    animateTo({ duration: 300 }, () => {
      this.isShow = true
    })

  }

  closePage() {
    animateTo({ duration: 300 }, () => {
      this.isShow = !this.isShow
    })
  }
}


export interface MyDialogControllerOption {
  builder: () => void
  cancel: () => void
  confirm: () => void
}

export class MyDialogController {
  CustomDialogName: string = 'WINDOW_DIALOG_CUSTOM';
  builder: () => void
  pageClose?: () => void

  // constructor(options: MyDialogControllerOption) {
  //   this.options = options
  //  this.customBuilder = options.builder
  // }
  constructor(builder: () => void, close: ()=>void) {
    this.pageClose = close
    this.builder = builder
  }

  open() {
    let sub_windowClass: window.Window | undefined = undefined;
    let context = getContext(this) as common.UIAbilityContext;
    let config: window.Configuration = {
      name: this.CustomDialogName,
      windowType: window.WindowType.TYPE_DIALOG,
      ctx: context
    };
    try {
      // 1.创建应用子窗口。
      window.createWindow(config, (err: BusinessError, data) => {
        const errCode: number = err.code;
        if (errCode) {
          console.error('Failed to create the window. Cause: ' + JSON.stringify(err));
          return;
        }

        sub_windowClass = data;
        console.info('Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
        // 2.子窗口创建成功后，设置子窗口的位置、大小及相关属性等。
        let screen = display.getDefaultDisplaySync()
        sub_windowClass.moveWindowTo(screen.width*0.1, 180, (err) => {
          if (err.code) {
            console.error('Failed to move the window. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in moving the window.');
        });
        sub_windowClass.resize(screen.width, 250, (err) => {
          if (err.code) {
            console.error('Failed to change the window size. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in changing the window size.');
        });

        let para:Record<string, MyDialogController> = { 'MyDialogController': this};
        let localStorage: LocalStorage = new LocalStorage(para)
        // 3.为子窗口加载对应的目标页面。
        sub_windowClass.loadContent("pages/Encapsulation/DialogEmptyPage", localStorage, (err) => {
          if (err.code) {
            console.error('Failed to load the content. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in loading the content.');
        });
        // 3.显示子窗口。
        sub_windowClass?.showWindow((err) => {
          if (err.code) {
            console.error('Failed to show the window. Cause: ' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in showing the window.');
        });
      });
    } catch (exception) {
      console.error('Failed to create the window. Cause: ' + JSON.stringify(exception));
    }

  }

  close() {
    animateTo({duration:200,onFinish: () => {
        /*后 销毁window*/
        this.destroy()
      }
    }, () => {
      /*先 隐藏子视图*/
      if (this.pageClose) {
        this.pageClose()
      }
    })

  }

  destroy() {
    let currentWindow = window.findWindow(this.CustomDialogName)
    currentWindow?.destroyWindow((err) => {
      if (err.code) {
        console.error('Failed to close the window. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in closing the window.');
    })
  }
}