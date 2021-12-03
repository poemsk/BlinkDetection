## Blink Detection using Vision Framework in iOS

ဒီ example မှာ  Computer Visionနဲ့ ဆိုင်တဲ့ use case တွေမှာ Appleရဲ့ Vision Framework ကို ဘယ်လို အသုံးပြုလို့ရမလဲ လေ့လာလို့ရမှာ ဖြစ်ပါတယ်။ Machine Learning နဲ့ အကျွမ်းတဝင်ဖြစ်စရာ မလိုဘဲ လွယ်လွယ်ကူကူ သူနဲ့ဆိုင်တဲ့ အလုပ်တွေကို လွယ်လွယ်ကူကူ လုပ်လို့ရတာ တွေ့ရမှာ ဖြစ်ပါတယ်။ 

#### ၁။ Projectက ဘာအကြောင်းလဲ

app တွေမှာ KYC (Know Your Customer)  ပြုလုပ်ဖို့ သုံးကြတဲ့ Liveliness detection ခေါ် ကိုယ့်platform အသုံးပြုတဲ့လူက ဓာတ်ပုံထဲကလူ ဟုတ်မဟုတ် appထဲက ကင်မရာနဲ့ မျက်စိမှတ်ပြတာ၊ ခေါင်းညိမ့်ပြရတာ စသဖြင့် လုပ်ရလေ့ ရှိပါတယ်။ ဒီProjectမှာ ဖုန်းကင်မရာကို အသုံးပြုပြီး Live Feedမှာ မျက်စိမှတ်မမှိတ် စစ်ပေးမှာ ဖြစ်ပါတယ်။ ဒီအတွက် Computer Vision မှာ Image Classification လို့ ခေါ်တဲ့နည်းကို သုံးပြီး camera feedက ရလာတဲ့ ဓာတ်ပုံမှာ လူမျက်နှာကို ရှာ၊ မျက်နှာပေါ်က မျက်လုံး၊ ပါးစပ်စတာတွေကို detect လုပ်ပြီး မျက်လုံးမှိတ်မမှိတ် စစ်ပေးမှာ ဖြစ်ပါတယ်။ 

#### ၂။ မစခင် ဘာတွေ လိုအပ်မလဲ

iOS Project ကို ရေးဖို့အတွက် Xcode လိုပါတယ်။ ကင်မရာစမ်းဖို့ iPhone ရှိဖို့လည်း လိုအပ်ပါတယ်။ 

#### ၃။ Project စဖန်တီးမယ်

၁. အရင်ဆုံး Xcode ဖွင့်ပြီး File -> New -> Project ကို ရွေး၍ Project အသစ် တစ်ခု ဖန်တီးပါ။ 

၂. App ဖန်တီးမှာ ဖြစ်တာကြောင့် Appကို ရွေးပါ။ 

![Screenshot 2021-12-03 at 4.07.29 PM](https://github.com/PoePoeMyintSwe/BlinkDetection/blob/main/images/1.png?raw=true)

၃. Next ကို နှိပ်၍ Project အတွက် လိုအပ်တာတွေ ဖြည့်ပါ။ ကျွန်တော်ကတော့ BlinkDetection လို့ ပေးထားပါတယ်။ Organization Identifierကတော့ အဆင်ပြေတာ ထည့်လို့ ရပါတယ်။ iPhoneမှာ စမ်းမှာဖြစ်လို့ Teamတော့ လိုပါတယ်။ မရှိရင်တော့ စမ်းလို့ မရပေမဲ့ လိုက်လုပ်လို့တော့ ရပါတယ်။ ဒီ Project မှာ UIKit သုံးပြီး ရေးမှာ ဖြစ်လို့ Storyboardရွေးထားပါတယ်။  iOS 13 အထက် Device တွေကိုပဲ target ထားချင်ရင် SwiftUI သုံးလို့ရပါတယ်။

![Screenshot 2021-12-03 at 4.20.09 PM](https://github.com/PoePoeMyintSwe/BlinkDetection/blob/main/images/2.png?raw=true)

၄. နောက်အဆင့်မှာတော့ project သိမ်းမဲ့ နေရာရွေးပြီး Create နှိပ်လိုက်ရုံပါပဲ။ 

![Screenshot 2021-12-03 at 4.25.49 PM](https://github.com/PoePoeMyintSwe/BlinkDetection/blob/main/images/3.png?raw=true)

#### ၄။ စရေးမယ်

iOSရဲ့ UIKitမှာက Storyboardကို UI ဆောက်ဖို့အတွက် သုံးပြီး Code ကိုကျတော့ ViewControllerမှာ ရေးရပါတယ်။ Project စတဲ့အချိန်မှာ Default အနေနဲ့ Main ဆိုတဲ့ Storyboardရယ်၊ သူနဲ့ ချိတ်ထားတဲ့ ViewControllerကို တွေ့ရမှာ ဖြစ်ပါတယ်။ ဘာမှ မရေးရသေးတဲ့ ViewContollerမှာ ဒီလို တွေ့ရမှာ ဖြစ်ပါတယ်။ 

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
```

#### ၅။ ကင်မရာက မြင်ရတာကို UI မှာ ပြမယ်

ပထမဆုံး ကင်မရာ၊ ဗီဒီယိုနဲ့ အသံတွေ စတဲ့ မီဒီယာနဲ့ ပက်သတ်တာတွေကို ထိန်းချုပ်ဖို့အတွက် iOS မှာ ပါပြီးသား AVFoundation ဆိုတဲ့ framework ကို သုံးပါမယ်။ 

```swift
import AVFoundation
```

ViewControllerမှာ  ကင်မရာကနေ feedကို ယူဖို့  AVCaptureSession တစ်ခု အရင် ကြေငြာရပါမယ်။ 

```swift
fileprivate var captureSession = AVCaptureSession()
```

AVCaptureSession ကို ရှေ့ကင်မရာနဲ့ ချိတ်မယ်။ 

```swift
private func connectCameratoSessionInput() {
        
    guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                    for: .video,
                                                    position: .front)
    else {
      fatalError("No front camera is found")
    }

    do {
      let deviceInput = try AVCaptureDeviceInput(device: frontCamera)
      captureSession.addInput(deviceInput)
    } catch {
      fatalError(error.localizedDescription)
    }
}
```

ကင်မရာက မြင်ရတာကို AVCaptureSession ကနေ တဆင့် UIမှာ တိုက်ရိုက်ပြဖို့ အတွက် Preview တစ်ခုလည်း ဖန်တီးရဦးမယ်။ 

```swift
fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = {
    var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = .resizeAspectFill
    return previewLayer
}()
```

Previewကို တခါ screen မှာ ပေါ်ဖို့အတွက် UIViewမှာ ထည့်ရဦးမယ်။ 

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    view.layer.addSublayer(previewLayer)
}
```

`previewLayer`ရဲ့ frame သတ်မှတ်ပေးမှ UIပေါ်မှာ ပေါ်လာမှာ ဖြစ်တာကြောင့် `viewDidLayoutSubviews()` မှာ screen ရဲ့ frameအတိုင်း သတ်မှတ်ပေးပါမယ်။ `viewDidLayoutSubviews()` ကတော့ `subView`တွေ layout ပြောင်းသွားရင် အကြောင်းကြားပေးတဲ့ methodပဲ ဖြစ်ပါတယ်။ 

```swift
override func viewDidLayoutSubviews() {
  super.viewDidLayoutSubviews()
  self.previewLayer.frame = view.frame
}
```

ကင်မရာနဲ့လည်း ချိတ်ပြီးပြီ။ Previewလည်း ရပြီ ဆိုရင် `viewDidLoad()` မှာ captureSession ကို စပြီး အလုပ်လုပ်ခိုင်းလို့ ရပါပြီ။ 

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.connectCameratoSessionInput()
    self.captureSession.startRunning()
}
```

#### ၆။ ကင်မရာသုံးမဲ့အကြောင်း Permission  ကြေငြာမယ်။ 

Projectကို ဖုန်းနဲ့ချိတ်ပြီး စမ်းကြည့်လိုက်ရင် ရှေ့ကင်မရာက feedကို စမြင်ရဖို့အတွက် ရေးလို့ ပြီးပါပြီ။ ဒါပေမဲ့ ကင်မရာ permission မရှိတဲ့အတွက် App က crash ဖြစ်နိုင်ပါတယ်။ ဒါကြောင့် Info.plist မှာ Camera သုံးမဲ့အကြောင်း Permission ကြေငြာပေးရပါဦးမယ်။ 

`Privacy - Camera Usage Description` ဆိုပြီး row အသစ်တစ်ခု ထည့်ပြီး description ရေးပေးပါ။ ဒါဆိုရင် Run ကြည့်လို့ ရပါပြီ။ 

#### ၆။ ကင်မရာကနေ ဓာတ်ပုံယူမယ်

ကင်မရာကနေ မြင်ရတဲ့ Live Feedကနေ ဓာတ်ပုံယူမယ်။ ပြီးရင် အဲ့ဓာတ်ပုံကို Vision Framework ကိုသုံးပြီး မျက်နှာကို ရှာပါမယ်။ အရင်ဆုံး ကင်မရာမြင်ရတာက အဆက်မပြတ်ဖြစ်တာကြောင့် DispatchQueue ကို သုံးဖို့ လိုပါမယ်။ DispactchQueue ကို taskတွေ တစ်ခုပြီးတစ်ခု (သို့) တပြိုင်နက် အများကြီး လုပ်ချင်တဲ့အခါ သုံးပါတယ်။ 

```swift
private let videoOutputQueue = DispatchQueue(label: "video output queue",
                                     qos: .userInitiated,
                                     attributes: [])
```

ပြီးရင် ကင်မရာကရလာတဲ့ ပုံတွေကို AVCaptureSessionကနေ တဆင့်ယူဖို့ AVCaptureVideoDataOutput ဆိုတာလေး တစ်ခုကို configure လုပ်ပေးရပါမယ်။ သူကမှ တဆင့် အဆက်မပြတ် ရလာတဲ့ပုံတွေကို Delegate သုံးပြီး ViewControllerမှာ ယူရမှာ ဖြစ်ပါတယ်။ 

```swift
private func getOutputFrames() {
    let output = AVCaptureVideoDataOutput()
    output.videoSettings = [
      String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
    ]

    output.alwaysDiscardsLateVideoFrames = true
    output.setSampleBufferDelegate(self, queue: videoOutputQueue)
    self.captureSession.addOutput(output)
}
```

ဒါပေမဲ့ ViewControllerက Delegate ကို လိုက်နာမထားတဲ့အတွက် `output.setSampleBufferDelegate(self, queue: videoOutputQueue)` ဆိုတဲ့ lineက error တက်ပါလိမ့်မယ်။ 

```swift
Argument type 'ViewController' does not conform to expected type 'AVCaptureVideoDataOutputSampleBufferDelegate'
```

ဒါကို ဖြေရှင်းဖို့အတွက် ViewControllerမှာ `AVCaptureVideoDataOutputSampleBufferDelegate` ကို ထည့်ပေးလိုက်ပါမယ်။  ဒါဆိုရင် အပေါ်က error ပျောက်သွားပါလိမ့်မယ်။။ Code ကို ပိုပြီး ရှင်းလင်းအောင်လို့ ViewControllerကို extension လုပ်လိုက်ပါတယ်။ 

```swift
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  
}
```

ပြီးရင်တော့ အပေါ်က AVCaptureVideoDataOutput ကနေ ရလာတဲ့ frame (ဝါ) ပုံတွေကို ViewController မှာ process လုပ်ဖို့အတွက် AVCaptureVideoDataOutputSampleBufferDelegateက captureOutput method နှစ်ခုထဲကမှ didOutputပါတာဟာကို သုံးပါမယ်။ 

```swift
func captureOutput(_ output: AVCaptureOutput,
                   didOutput sampleBuffer: CMSampleBuffer,
                   from connection: AVCaptureConnection) {
		// process frames here
}
```

ပြီးရင်တော့  `viewDidLoad()`ကို ပြန်သွားပြီး `captureSession`ကို မစခင်  `getOutputFrames()` ကို ခေါ်ပေးရပါမယ်။ 

```swift
self.getOutputFrames()
```

#### ၇။ ရလာတဲ့ frameတွေမှာ မျက်နှာကို ရှာမယ်

ပထမဆုံး Vision ကို import လုပ်ရပါမယ်။ သူက iOS 11 အထက်စပြီး သုံးလို့ရတယ်။ CoreImage မှာကတည်း face detection ပါပေမဲ့ Visionကတော့ Machine Learning သုံးတာဖြစ်လို့ သူ့ Algorithm က ပိုတိကျတယ်။ classအစမှာ framework ကို import လုပ်မယ်။ 

```swift
import Vision
```

နောက် Video Outputကနေ ရလာတဲ့ frameမှာ မျက်နှာရဲ့ မျက်လုံးတို့၊ ပါးစပ်တို့ ရှာမယ်။ Vision Framework ရဲ့ VNDetectFaceLandmarksRequest က မျက်နှာတင်သာမက မျက်လုံး၊ နှာခေါင်း၊ ပါးစပ်ပါ ပေးတာ ဖြစ်တာကြောင့် သူ့ကိုပဲ သုံးထားပါတယ်။ မျက်နှာပဲလိုချင်တယ်ဆိုရင်တော့ VNDetectFaceRectanglesRequest ကို သုံးလို့ရပါတယ်။ Request လုပ်ပြီး ရလာတဲ့ မျက်နှာတွေကို VNFaceObservation ဆိုပြီး array အနေနဲ့ ထုတ်ပေးပါတယ်။ Requestကို execute လုပ်ဖို့ VNSequenceRequestHandler ထဲ ထည့်ပေးရပါတယ်။ 

```swift
func detectFace(in image: CVImageBuffer) {
    let detectFaceRequest = VNDetectFaceLandmarksRequest { request, error in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let results = request.results as? [VNFaceObservation], !results.isEmpty else {
            print("No face detected")
            return
        }
        
        if results.count > 1 {
            print("More than one face detected")
            return
        }
                                                          
        print("Face Detected")                                           
        //do processing of face here
    }
    
    let sequenceRequestHandler = VNSequenceRequestHandler()
    do {
        try sequenceRequestHandler.perform([detectFaceRequest],
                                           on: image,
                                           orientation: .leftMirrored)
    } catch {
        print(error.localizedDescription)
    }
    
}
```

အပေါ်က function ကို `captureOutput` မှာ ခေါ်သုံးမယ်။ 

```swift
func captureOutput(_ output: AVCaptureOutput,
                   didOutput sampleBuffer: CMSampleBuffer,
                   from connection: AVCaptureConnection) {
    
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      	print("cannot get imagebuffer")
        return
    }
  	self.detectFace(in: imageBuffer)
}
```

projectကို run ကြည့်တဲ့အခါ မျက်နှာကို တွေ့လားမတွေ့လား console မှာ စာထုတ်ပေးမှာ ဖြစ်ပါတယ်။ 

#### ၈။ မျက်စိမှိတ်မမှိတ် စစ်တဲ့ algorithm ရေးမယ်

ကင်မရာ feedကနေ မျက်လုံး ရလာပြီဆိုရင် မျက်လုံး မှိတ်လား မမှိတ်လား စစ်လို့ ရပါပြီ။  မျက်လုံးမှာ normalized points ခြောက်ခု ရှိပြီး မျက်လုံးမှိတ်သွားတဲ့အချိန်မှာ အပေါ်အောက်  နှစ်ခုကြား အကွာအဝေးက လျော့နည်းသွားမှာ ဖြစ်ပါတယ်။ 

![EAR](https://github.com/PoePoeMyintSwe/BlinkDetection/blob/main/images/5.png?raw=true)

၂၀၁၆မှာ ထုတ်ဝေခဲ့တဲ့ Real-Time Eye Blink Detection using Facial Landmarks ဆိုတဲ့ ပေပါအရ Eye Aspect Ratio တွက်တဲ့ formula က ဒီလိုရှိပါတယ်။

![Formula](https://github.com/PoePoeMyintSwe/BlinkDetection/blob/main/images/4.png?raw=true)

အရင်ဆုံး Point နှစ်ခုကြားက အကွာအဝေး ရှာတဲ့ formulaကို CGPointမှာ extension အနေနဲ့ ရေးမယ်။ 

```swift
extension CGPoint {
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

```

မျက်စိမှတ်တာကို စစ်တဲ့ class သပ်သပ်ရေးမယ်။ ဒီထဲမှာ အပေါ်က ပါတဲ့ formulatအတိုင်း မျက်စိပွင့်နေရင် ပမာဏ များပြီး မှိတ်ရင် ပမာဏ နည်းတာကို စစ်ပြီး threshold ယူ တွက်ပါမယ်။ 

```swift
fileprivate func getEAR(with eyePoints:[CGPoint]) -> CGFloat {
    let A = eyePoints[1].distance(to: eyePoints[5])
    let B = eyePoints[2].distance(to: eyePoints[4])
    let C = eyePoints[0].distance(to: eyePoints[3])
    // compute the eye aspect ratio
    return (A + B) / (2.0 * C)
}
```

Aspect Ratioတွက်တဲ့ function ရပြီဆိုတော့ Visionကရလာတဲ့ မျက်လုံးက normalized pointsတွေ ထည့်ပြီး တွက်ပါမယ်။ ဒီအတွက် class သပ်သပ် ရေးလိုက်ပါမယ်။​ 

အရင်ဆုံး BlinkDetectorဆိုတဲ့ class ထဲမှာ မျက်လုံးရဲ့ state တွေကို enum အနေနဲ့ list လုပ်ထားပါမယ်။ 

```swift
import Vision

class BlinkDetector {
    
    enum State {
        case eyes_opened
        case eyes_closed
        case blinked
        case stop
    }
}
```

စစချင်းမှာ မျက်လုံးက ပွင့်နေတယ်လို့ သဘောထားပြီး initial state ကို eyes_opened လို့ ထားလိုက်မယ်။

```swift
 fileprivate var state: State = .eyes_opened
```

နောက် အပေါ်က စာတမ်းထဲကအတိုင်း  Aspect Rationက ၀.၁အောက်ဆိုရင် မျက်လုံးမှိတ်သွားတယ်လို့ ယူဆပြီး သူ့ကို မူတည်ပြီး တွက်ပါမယ်။ 

```swift
fileprivate let EYES_CLOSE_THREADSHOLD: CGFloat = 0.1
```

ဒါဆိုရင် တော့ မျက်လုံးမှိတ်မမှိတ်တွက်တဲ့ functionလေးကို အောက်ကအတိုင်း ရေးမယ်။ 

```swift
func detectBlink(of faceObservation: VNFaceObservation) {
    
    guard
        let leftEye = faceObservation.landmarks?.leftEye,
        let rightEye = faceObservation.landmarks?.rightEye
        else { return }
    
    let leftEAR = self.getEAR(with: leftEye.normalizedPoints)
    let rightEAR = self.getEAR(with: rightEye.normalizedPoints)
    
    print("left: \(leftEAR), right: \(rightEAR)")
    
    switch state {
    case .eyes_opened:
        if leftEAR > EYES_CLOSE_THREADSHOLD && rightEAR > EYES_CLOSE_THREADSHOLD  {
            state = .eyes_closed
        }
        break
    case .eyes_closed:
        if leftEAR < EYES_CLOSE_THREADSHOLD && rightEAR < EYES_CLOSE_THREADSHOLD  {
            state = .blinked
            
        }
        break
    case .blinked:
        if leftEAR > EYES_CLOSE_THREADSHOLD && rightEAR > EYES_CLOSE_THREADSHOLD {
            state = .stop=
        }
        break
    case .stop:
        break
    }
}
```

မျက်လုံးမှိတ်ပြီး ပြန်ဖွင့်တာကို စစ်တာ ဖွင့်တဲ့အတွက် ပထမဆုံး မျက်လုံးပွင့်နေလို့ default ယူဆထားတယ်။ ဒီအတွက် မျက်စိပွင့်နေတုန်းမှာ ပိတ်တာလားလို့ စစ်ချင်တဲ့အတွက် state ကို `eye_closed` လို့ ပြောင်းတယ်။ `eye_closed` ချိန်မှာ စစ်လို့ တကယ်လို့ မျက်လုံးပိတ်သွားတယ်ဆိုရင် `blinked` state ကို ပြောင်းပေးတယ်။ ပြီးမှ မျက်လုံးပြန်ဖွင့်တာ သေချာမှာ blink detected ဖြစ်သွားပါတယ်။ 

ဒီ classကို ​ViewControllerကနေ ခေါ်သုံးလို့ရအောင် Delegate သုံးပြီး ရေးပါမယ်။ 

```swift
protocol BlinkDetectorDelegate {
    func didBlink()
}
```

ပြီးရင် BlinkDetector ထဲမှာ ကြေငြာမယ်။ 

```swift
var delegate: BlinkDetectorDelegate?
```

ဒါကို conform လုပ်တဲ့ ViewControllerကို အကြောင်းကြားဖို့အတွင် `blinked` ဆိုတဲ့ case မှာ ခေါ်မယ်။ 

```swift
delegate?didBlink()
```

#### ၉။ UIကနေ မျက်စိမှိတ်မမှိတ် စစ်မယ်။ 

အရင်ဆုံး BlinkDetectorကို ViewControllerမှာ ကြေငြာမယ်။ 

```swift
 fileprivate lazy var blinkDetector: BlinkDetector = {
        let blinkDetector = BlinkDetector()
        blinkDetector.delegate = self
        return blinkDetector
 }()
```

 BlinkDetectorDelegateကို ViewControllerက conform လုပ်ပေးရမယ်။​

```swift
extension ViewController: BlinkDetectorDelegate {
    
    func didBlink() {
        print("blink detected")
    }
}
```

ပြီးရင် `detectFace` ဆိုတဲ့ function မှာ ခေါ်ပြီး သုံးရုံပါပဲ။ 

```swift
 guard let observation = results.first else { return }
 self.blinkDetector.detectBlink(of: observation)
```

#### ၁၀။ ဂုဏ်ယူပါတယ်

အခုဆိုရင် ကျွန်တော်တို့ Appleရဲ့ ရှိပြီးသား framework တွေကို သုံးပြီး Camera Live Feedကနေ Liveliness စစ်တဲ့ feature တစ်ခုဖြစ်တဲ့ မျက်လုံးမှိတ်ပြီး ပြန်ဖွင့်တာကို စစ်တာကို ရေးခဲ့ပြီး ဖြစ်ပါတယ်။ Vision framework ဟာ တခြား အသုံးဝင်တာတွေ အများကြီး ရှိသေးတာကြောင့် ကိုယ် ညဏ်ကွန့်ချင်သလို့ သုံးလို့ရပါတယ်။ ပြီးတော့ Core ML ကို သုံးပြီး ML Model တွေကို ဖုန်းမှာလည်း deploy လုပ်လို့ ရပါသေးတယ်။ ဒီproject စကြည့်ရင်း လေ့လာဖို့ အသုံးဝင်မယ် မျှော်လင့်ပါတယ်။ 

Happy Coding!!!