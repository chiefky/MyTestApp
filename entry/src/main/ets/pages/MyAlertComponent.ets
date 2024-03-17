import BrokerToast from './BrokerToast'

@Component
export struct MyAlertComponent {
  @State textValue: string = ''
  @State inputValue: string = 'click me'
  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        // BrokerToast()
        Image($r('app.media.broker')).width(100).height(100)
      }
    }
    .width('100%')
    .height('100%')
    // 组件添加时从底部滑出，透明度从0到1.0
    .transition({ type: TransitionType.Insert, translate: { x: 0, y: -500, z: 0 }, opacity: 1.0 })
    // 组件移除从底部滑出，透明度从1.0到0
    .transition({ type: TransitionType.Delete, translate: { x: 0, y: -500, z: 0 }, opacity: 0 })

  }
}

