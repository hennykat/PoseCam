//
//  CameraViewController.swift
//  PoseCam
//
//  Created by Emily Hennessy on 5/19/19.
//  Copyright © 2019 hennykat. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    let previewView = PreviewView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previewView.frame = self.view.frame
        self.view.addSubview(previewView)
        
        setupCamera()
    }
    
    func setupCamera() {
        // discover all possible devices
        let devices = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera],
            mediaType: .video,
            position: .back).devices
        
        guard let bestDevice = devices.first else { fatalError("No camera devices")}
        captureSession.beginConfiguration()
        guard let deviceInput = try? AVCaptureDeviceInput(device: bestDevice),
            captureSession.canAddInput(deviceInput) else {
                print("Failed to add video input")
                return
        }
        captureSession.addInput(deviceInput)
        captureSession.commitConfiguration()
        
        previewView.videoPreviewLayer.session = captureSession
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
