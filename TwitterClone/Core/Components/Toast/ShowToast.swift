//
//  ShowToast.swift
//  TwitterClone
//
//  Created by Robotics on 2/5/2023.
//

import UIKit
import SwiftUI
import Toast_Swift


class ShowToast : NSObject {
    static let shearedInstance = ShowToast()
    
    func showToast(message: String, duration: Double = 2, position: ToastPosition = ToastManager.shared.position, backgroundColor: UIColor = .black, image: UIImage? = nil){
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        if let view = window!.rootViewController?.view {
            view.makeToast(message, duration: TimeInterval(duration), position: position, image: image, style: ToastStyle(backgroundColor: backgroundColor.withAlphaComponent(0.9)))
        }
    }
    
    func dismissToast(){
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        if let view = window!.rootViewController?.view {
            view.hideAllToasts()
        }
    }
    
}
