import window from '@ohos.window';
import common from '@ohos.app.ability.common';

import { BusinessError } from '@ohos.base';
import CustomDialogUser from "./CustomDialogUser";
import { ToastController } from "./ToastController";
import promptAction from '@ohos.promptAction';
import BrokerToast from './BrokerToast';
import { Position } from '@kit.ArkUI';
import { MyDialogController } from './Encapsulation/DialogEmptyPage';
import { MyAlertComponent } from './MyAlertComponent';

let sub_windowClass: window.Window | undefined = undefined;

@Entry
@Component
struct Index {
  @State message: string = '点击我啊~~'
  @State textValue: string = ''
  @State inputValue: string = 'click me'
  @State isShow: boolean = false
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
  diaController: MyDialogController = new MyDialogController(this.myAlert.bind(this), this.onCancel)
  onCancel() {
    this.diaController.close()
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
    BrokerToast({
      cancel: this.onCancel.bind(this)
    })
  }

  build() {
    Column({ space: 10 }) {
      /*使用subwindow显示弹窗*/
      Stack() {
        Column() {
          Text("使用普通view显示弹窗,").margin({ top: 20 }).width('100%').textAlign(TextAlign.Center)
          Button(this.isShow ? '隐藏' : "显示")
            .width('100%')
            .height(40)
            .onClick(() => {
              console.log("❀：哈哈哈，大猪头~~~~")
              this.viewShowOrHidden()
            })
        }

        if (this.isShow) {
          MyAlertComponent({
            onCancel: this.viewShowOrHidden.bind(this)
          }).backgroundColor('#ff9fff').width('100%').height(100)
        }
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

  viewShowOrHidden() {
    animateTo({ duration: 600 }, () => {
      this.isShow = !this.isShow
    })
  }

  showToast() {
    promptAction.showToast({ message: "❀：哈哈哈，大猪头~~~~", duration: 2000 })
  }

  // moveWindowTo(position: Position) {
  //   sub_windowClass?.moveWindowTo(position.x,position.y)
  // }
}