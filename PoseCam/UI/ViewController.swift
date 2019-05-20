//
//  ViewController.swift
//  PoseCam
//
//  Created by Emily Hennessy on 5/19/19.
//  Copyright © 2019 hennykat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            showCameraScreen()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.showCameraScreen()
                } else {
                    print("not granted")
                    // direct user to settings
                }
            }
        case .denied:
            print("denied")
            // direct user to settings
        default:
            print("unknown")
        }
    }
    
    func showCameraScreen() {
        let viewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "CameraViewController")
        present(viewController, animated: true, completion: nil)
    }
    
}
