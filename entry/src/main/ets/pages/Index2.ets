import window from '@ohos.window';
import common from '@ohos.app.ability.common';

import { BusinessError } from '@ohos.base';
import CustomDialogUser from "./CustomDialogUser";
import { ToastController } from "./ToastController";
import promptAction from '@ohos.promptAction';
import BrokerToast from './BrokerToast';
import { Position } from '@kit.ArkUI';
import { MyDialogController } from './Encapsulation/DialogEmptyPage';

let sub_windowClass: window.Window | undefined = undefined;

@Entry
@Component
struct Index {
  @State message: string = '点击我啊~~'
  @State textValue: string = ''
  @State inputValue: string = 'click me'
  subwindowController: CustomDialogController = new CustomDialogController({
    builder: this.myAlert,
    cancel: this.exitApp,
    showInSubWindow: true
  })
  animationController: CustomDialogController = new CustomDialogController({
    builder: this.myAlert,
    cancel: this.exitApp,
    openAnimation: {
      duration: 2000, onFinish: () => {

      }
    },
    closeAnimation: {
      duration: 2000, onFinish: () => {
      }
    }
  })
  diaController: MyDialogController = new MyDialogController(this.myAlert, this.onCancel)

  // diaController:MyDialogController = new MyDialogController({
  //    builder: this.myAlert,
  //    cancel: this.onCancel,
  //    confirm: this.onAccept
  //  })

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }

  @Builder
  myAlert() {
    BrokerToast()
  }

  build() {
    Column({ space: 30 }) {
      /*使用subwindow显示弹窗*/
      Column() {
        Text("使用subwindow显示弹窗,").margin({ top: 20 }).width('100%').textAlign(TextAlign.Center)
        Button('加载EmptyPage ')
          .width('100%')
          .height(40)
          .onClick(() => {
            console.log("❀：哈哈哈，大猪头~~~~")
            this.creatSubWindowByWindow()
          })
      }.width('90%')

      /*使用封装后subwindow显示弹窗*/
      Column() {
        Text("使用封装subwindow显示弹窗").margin({ top: 20 }).width('100%').textAlign(TextAlign.Center)
        Button('加载DialogEmptyPage')
          .width('100%')
          .height(40)
          .onClick(() => {
            console.log("❀：哈哈哈，大猪头~~~~")
            this.diaController.open()
          })
      }.width('90%')

      Button('使用系统自定义弹窗：无动画')
        .height(40)
        .onClick(() => {
          console.log("❀：哈哈哈，大猪头~~~~")
          this.subwindowController.open();
        })
      Button('使用系统自定义弹窗')
        .width('90%')
        .height(40)
        .onClick(() => {
          console.log("❀：哈哈哈，大猪头~~~~")
          this.subwindowController.open();
        })

      Button('测试是否可点击').width('90%').height(40).onClick(() => {
        this.showToast()
      })
    }
    .width('100%')
    .height('100%')
  }

  creatSubWindowByWindow() {
    let context = getContext(this) as common.UIAbilityContext;
    let config: window.Configuration = {
      name: "MyAlertWindow",
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
        sub_windowClass.moveWindowTo(0, 80, (err) => {
          if (err.code) {
            console.error('Failed to move the window. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in moving the window.');
        });
        sub_windowClass.resize(1300, 400, (err) => {
          if (err.code) {
            console.error('Failed to change the window size. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in changing the window size.');
        });
        // 3.为子窗口加载对应的目标页面。
        sub_windowClass.setUIContent("pages/tmp/EmptyPage", (err) => {
          if (err.code) {
            console.error('Failed to load the content. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in loading the content.');

        });
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

  // showWindow() {
  //   animateTo({ duration: 600 }, () => {
  //     this.isShow = !this.isShow
  //   })
  // }

  showToast() {
    promptAction.showToast({ message: "❀：哈哈哈，大猪头~~~~", duration: 2000 })
  }

  // moveWindowTo(position: Position) {
  //   sub_windowClass?.moveWindowTo(position.x,position.y)
  // }
}