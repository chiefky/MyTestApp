import { AbilityConstant, common, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@ohos.base';

let windowStage_: window.WindowStage | null = null;
let sub_windowClass: window.Window | null = null;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    let para:Record<string, window.WindowStage> = {'windowStage': windowStage}
    let localStorage: LocalStorage = new LocalStorage(para)

    windowStage.loadContent('pages/IndexFloatLayer', localStorage, (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    // this.creatSubWindowByWindow()
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  creatSubWindowByWindow(){
    let sub_windowClass: window.Window | undefined = undefined;
    // let context = getContext(this) as common.UIAbilityContext;
    let config: window.Configuration = {
      name: "alertWindow",
      windowType: window.WindowType.TYPE_DIALOG,
      ctx: this.context
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
  }
  creatSubWindow(stage:window.WindowStage) {
    /*创建子window*/
    windowStage_ = stage;
    windowStage_.createSubWindow("mySubWindow", (err: BusinessError, data) => {
      let errCode: number = err.code;
      if (errCode) {
        console.error('Failed to create the subwindow. Cause: ' + JSON.stringify(err));
        return;
      }
      sub_windowClass = data;
      console.info('Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
      // 2.子窗口创建成功后，设置子窗口的位置、大小及相关属性等。
      sub_windowClass.moveWindowTo(300, 300, (err: BusinessError) => {
        let errCode: number = err.code;
        if (errCode) {
          console.error('Failed to move the window. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in moving the window.');
      });
      sub_windowClass.resize(500, 500, (err: BusinessError) => {
        let errCode: number = err.code;
        if (errCode) {
          console.error('Failed to change the window size. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in changing the window size.');
      });
      // 3.为子窗口加载对应的目标页面。
      sub_windowClass.setUIContent("pages/EmptyPage", (err: BusinessError) => {
        let errCode: number = err.code;
        if (errCode) {
          console.error('Failed to load the content. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in loading the content.');
        // 3.显示子窗口。
        (sub_windowClass as window.Window).showWindow((err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            console.error('Failed to show the window. Cause: ' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in showing the window.');
        });
      });
    })
  }
}
