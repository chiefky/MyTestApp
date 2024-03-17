import { window } from '@kit.ArkUI'

declare interface WindowManagerOptions {
  // window:
  show:()=>void
  close:()=>void
  move:()=>void
}

class WindowManager {
  option:WindowManagerOptions
  constructor(option:WindowManagerOptions) {
    this.option = option
  }
}