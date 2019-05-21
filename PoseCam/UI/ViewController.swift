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
                DispatchQueue.main.async {
                    if granted {
                        self.showCameraScreen()
                    } else {
                        self.requestAllowingCameraInSettings()
                    }
                }
            }
        case .denied:
            self.requestAllowingCameraInSettings()
        default:
            fatalError("Failed to request camera auth")
        }
    }
    
    func showCameraScreen() {
        let viewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "CameraViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func requestAllowingCameraInSettings() {
        let alertController = UIAlertController(
            title: "Camera Use Is Required",
            message: "Enable in Settings",
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
}
