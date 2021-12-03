//
//  ViewController.swift
//  BlinkDetection
//
//  Created by Poe on 1/12/21.
//

import AVFoundation
import UIKit
import Vision

class ViewController: UIViewController {

    fileprivate var captureSession = AVCaptureSession()
    
    fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }()
    
    private let videoOutputQueue = DispatchQueue(label: "video output queue",
                                         qos: .userInitiated,
                                         attributes: [])
    
    fileprivate lazy var blinkDetector: BlinkDetector = {
        let blinkDetector = BlinkDetector()
        blinkDetector.delegate = self
        return blinkDetector
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.connectCameratoSessionInput()
        self.getOutputFrames()
        self.captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layer.addSublayer(previewLayer)
    }
}

// MARK: AVCaptureSession configuration
extension ViewController {
    
    private func connectCameratoSessionInput() {
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                        for: .video,
                                                        position: .front)
        else {
            fatalError("No front camera")
        }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: frontCamera)
            captureSession.addInput(deviceInput)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func getOutputFrames() {
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [
            String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
        ]
        
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: videoOutputQueue)
        self.captureSession.addOutput(output)
    }
}

// MARK: AVCaptureVideoDataOutput processing
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("cannot get imagebuffer")
            return
        }
        self.detectFace(in: imageBuffer)
    }

}

// MARK: Video Frame Processing

extension ViewController {
    
    func detectFace(in image: CVImageBuffer) {
    
        let detectFaceRequest = VNDetectFaceLandmarksRequest { request, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            
            guard let results = request.results as? [VNFaceObservation], !results.isEmpty else {
//                print("No face detected")
                return
            }
            
            if results.count > 1 {
//                print("More than one face detected")
                return
            }
            
            guard let observation = results.first else { return }
            self.blinkDetector.detectBlink(of: observation)
           
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
}


extension ViewController: BlinkDetectorDelegate {
    
    func didBlink() {
        print("blink detected and detection is stopped")
    }
}

