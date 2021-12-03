//
//  BlinkDetector.swift
//  BlinkDetection
//
//  Created by Poe on 4/12/21.
//

import Foundation
import Vision

protocol BlinkDetectorDelegate {
    func didBlink()
}

class BlinkDetector {
    
    enum State {
        case eyes_opened
        case eyes_closed
        case blinked
        case stop
    }
    
    var delegate: BlinkDetectorDelegate?
    
    fileprivate let EYES_CLOSE_THREADSHOLD: CGFloat = 0.1
    fileprivate var state: State = .eyes_opened
    
func detectBlink(of faceObservation: VNFaceObservation) {
    
    guard
        let leftEye = faceObservation.landmarks?.leftEye,
        let rightEye = faceObservation.landmarks?.rightEye
        else { return }
    
    let leftEAR = self.getEAR(with: leftEye.normalizedPoints)
    let rightEAR = self.getEAR(with: rightEye.normalizedPoints)
    
    
    
    switch state {
    case .eyes_opened:
        if leftEAR > EYES_CLOSE_THREADSHOLD && rightEAR > EYES_CLOSE_THREADSHOLD  {
            print("left: \(leftEAR), right: \(rightEAR)")
            print("eye opened")
            state = .eyes_closed
        }
        break
    case .eyes_closed:
        if leftEAR < EYES_CLOSE_THREADSHOLD && rightEAR < EYES_CLOSE_THREADSHOLD  {
            print("left: \(leftEAR), right: \(rightEAR)")
            state = .blinked
            print("eye closed")
        }
        break
    case .blinked:
        if leftEAR > EYES_CLOSE_THREADSHOLD && rightEAR > EYES_CLOSE_THREADSHOLD {
            print("left: \(leftEAR), right: \(rightEAR)")
            print("eye opened")
            state = .stop
            delegate?.didBlink()
        }
        break
    case .stop:
        break
    }
}
    
    func resetState() {
        self.state = .eyes_opened
    }
}

extension BlinkDetector {
    
    /// get eyes aspect ratio
    fileprivate func getEAR(with eyePoints:[CGPoint]) -> CGFloat {
        let A = eyePoints[1].distance(to: eyePoints[5])
        let B = eyePoints[2].distance(to: eyePoints[4])
        let C = eyePoints[0].distance(to: eyePoints[3])
        // compute the eye aspect ratio
        return (A + B) / (2.0 * C)
    }
}


extension CGPoint {
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}
