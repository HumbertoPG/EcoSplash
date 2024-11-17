//
//  EcoSplashApp.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 28/10/24.
//

import SwiftUI
import UserNotifications
import AVFoundation

extension Notification.Name {
    static let appWillEnterForeground = Notification.Name("appWillEnterForeground")
}

@main
struct EcoSplashApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var audioPlayer: AVAudioPlayer?
    
    init() {
        requestNotificationPermissions()
        playBackgroundMusic()
    }
    
    private mutating func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "background_sound", withExtension: "mp3") else {
            print("Archivo de música no encontrado")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop infinito
            audioPlayer?.play()
        } catch {
            print("Error al reproducir música: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error al solicitar permisos: \(error.localizedDescription)")
            } else {
                print("Permiso concedido: \(granted)")
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: .appDidEnterBackground, object: nil)
    }
    
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: .appWillEnterForeground, object: nil)
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("La aplicación ha terminado de lanzarse.")
    }
}
