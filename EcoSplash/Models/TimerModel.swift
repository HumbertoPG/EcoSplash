//
//  TimerModel.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 31/10/24.
//

import Foundation
import UserNotifications

class TimerModel: ObservableObject {
    
    private var levelManager: LevelManager
    private var coinManager: CoinManager
    private var strikeManager: StrikeManager
    private var statistics: Statistics
    private var achievementsManager: AchievementsManager
    
    @Published var timeRemaining: Double = 1200.0
    @Published var isRunning: Bool = false
    @Published var tankStatus: String = "full"
    @Published var axoloteStatus: String = "happy"
    
    private var hasScheduledNotification: Bool = false
    private var wastedWater: Double = 0.0
    private var timer: DispatchSourceTimer?
    private var targetDate: Date?
    
    init(levelManager: LevelManager, coinManager: CoinManager, strikeManager: StrikeManager, statistics: Statistics, achievementsManager: AchievementsManager) {
        self.levelManager = levelManager
        self.coinManager = coinManager
        self.strikeManager = strikeManager
        self.statistics = statistics
        self.achievementsManager = achievementsManager
        
        NotificationCenter.default.addObserver(self, selector: #selector(syncTimer), name: .appWillEnterForeground, object: nil)
    }
    
    func startTimer() {
        isRunning = true
        targetDate = Date().addingTimeInterval(timeRemaining)

        // Sincronizar inmediatamente `timeRemaining` antes de iniciar el temporizador
        let now = Date()
        timeRemaining = max(0, targetDate?.timeIntervalSince(now) ?? 0)

        // Configurar notificaciones
        scheduleNotification(for: Int(timeRemaining), title: "El tiempo terminó", body: "Hoy no ahorraste agua bañandote, ¡pero mañana puedes lograrlo!", identifier: "TimeOver")
        scheduleNotification(for: Int(timeRemaining - 240), title: "¡Apresurate!", body: "Te queda un minuto para registrar una ducha corta", identifier: "FifteenMinutesLeft")

        // Crear un DispatchSourceTimer
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer?.schedule(deadline: .now(), repeating: 1.0)
        timer?.setEventHandler { [weak self] in
            self?.tick()
        }
        timer?.resume()
    }

    
    func stopTimer(manual: Bool = true) {
        timer?.cancel()
        timer = nil
        isRunning = false
        hasScheduledNotification = false

        calculateRewards()

        if !manual && timeRemaining > 900 {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["FifteenMinutesLeft"])
        } else if !manual {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["FifteenMinutesLeft"])
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TimeOver"])
        }

        levelManager.addExperience(points: 240 - Int(wastedWater))
        statistics.totalSavedLiters += (240 - wastedWater)
        statistics.totalShowers += 1
        timeRemaining = 1200
        achievementsManager.updateProgress()
        tankStatus = "full"
        axoloteStatus = "happy"
    }

    
    private func tick() {
        guard let targetDate = targetDate else { return }

        let now = Date()
        let calculatedTime = max(0, targetDate.timeIntervalSince(now))

        if abs(calculatedTime - timeRemaining) > 0.001 { // Evitar actualizaciones innecesarias
            timeRemaining = calculatedTime
        }

        if timeRemaining <= 0 {
            stopTimer(manual: false)
        } else {
            wastedWater += 0.2
            updateAxoloteAndTankStatus()
        }
    }


    
    private func updateAxoloteAndTankStatus() {
        if timeRemaining == 600 {
            tankStatus = "half"
            axoloteStatus = "sad"
        } else if timeRemaining == 300 {
            tankStatus = "empty"
            axoloteStatus = "verysad"
        }
    }
    
    private func calculateRewards() {
        switch timeRemaining {
        case 900...1200:
            coinManager.addCoins(10 + (strikeManager.strikes / 5))
            strikeManager.addStrike()
            statistics.totalShortShowers += 1
        case 720..<900:
            coinManager.addCoins(5)
            strikeManager.resetStrikes()
        default:
            coinManager.addCoins(3)
            strikeManager.resetStrikes()
        }
    }
    
    
    func formattedTime() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    private func scheduleNotification(for timeInterval: Int, title: String, body: String, identifier: String) {
        guard timeInterval > 0 else { return }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error al programar notificación: \(error.localizedDescription)")
            }
        }
    }

    
    @objc private func syncTimer() {
        guard let targetDate = targetDate else { return }

        let now = Date()
        let calculatedTime = targetDate.timeIntervalSince(now)

        // Asegúrate de que `timeRemaining` nunca sea negativo
        if abs(calculatedTime - timeRemaining) > 0.001 {
            timeRemaining = max(0, calculatedTime)
        }
    }
    
}

extension Notification.Name {
    static let appDidEnterBackground = Notification.Name("appDidEnterBackground")
}
