//
//  editPhotoApp.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 30.07.2024.
//


import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
    struct editPhotoApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }

