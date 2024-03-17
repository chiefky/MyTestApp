import window from '@ohos.window';
import common from '@ohos.app.ability.common';

import { BusinessError } from '@ohos.base';
import CustomDialogUser from "./CustomDialogUser";
import { ToastController } from "./ToastController";
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct IndexTest {
  @State message: string = '点击我啊~~'
  dialogController: ToastController = new ToastController({
    builder: () => {

    },
    cancel: () => {

    }
  })

  build() {
    Column({ space: 100 }) {
      Button('创建subwindow')
        .width('90%')
        .height(40)
        .onClick(() => {
          let sub_windowClass: window.Window | undefined = undefined;
          let context = getContext(this) as common.UIAbilityContext;
          let config: window.Configuration = {
            name: "alertWindow",
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
              sub_windowClass.resize(1300, 200, (err) => {
                if (err.code) {
                  console.error('Failed to change the window size. Cause:' + JSON.stringify(err));
                  return;
                }
                console.info('Succeeded in changing the window size.');
              });
              // 3.为子窗口加载对应的目标页面。
              sub_windowClass.setUIContent("pages/EmptyPage", (err) => {
                if (err.code) {
                  console.error('Failed to load the content. Cause:' + JSON.stringify(err));
                  return;
                }
                console.info('Succeeded in loading the content.');
                // 3.显示子窗口。
                sub_windowClass?.showWindow((err) => {
                  if (err.code) {
                    console.error('Failed to show the window. Cause: ' + JSON.stringify(err));
                    return;
                  }
                  console.info('Succeeded in showing the window.');
                });
              });
            });
          } catch (exception) {
            console.error('Failed to create the window. Cause: ' + JSON.stringify(exception));
          }
        })

      Button('封装后subwindow')
        .width('90%')
        .height(40)
        .onClick(() => {
          console.log("❀：哈哈哈，大猪头~~~~")
          promptAction.showToast({
            message: "❀：哈哈哈，大猪头~~~~",
            duration: 2000
          })
          // this.dialogController.showSubWindow();
        })
    }
    .width('100%')
    .height('100%')
  }
}