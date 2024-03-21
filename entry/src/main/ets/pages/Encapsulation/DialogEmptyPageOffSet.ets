import { MyDialogController } from './DialogEmptyPage';

@Entry
@Component
struct DialogEmptyPageOffSet {
  @State widthSize: number = 100
  @State heightSize: number = 100
  @State isShow: boolean = false
  @State offsetY: number = -200
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
      Column(){
         if (typeof this.child === 'function') {
           this.child()
         }
       }
       .width('90%')
       .height(200)
       .offset({y:this.offsetY})
    }
    .backgroundColor('#008a8787')
    .width('100%').height('100%')
  }

  onPageShow(): void {
    setTimeout(()=>{
      animateTo({ duration: 300 }, () => {
        // this.isShow = true
        this.offsetY = 100
      })
    }, 100);
  }

  closePage() {
    animateTo({ duration: 300 }, () => {
      // this.isShow = !this.isShow
      this.offsetY = -100
    })
  }
}


