//
//  UserDefaultsKeyMacroSampleApp.swift
//  UserDefaultsKeyMacroSample
//
//  Created by HIROKI IKEUCHI on 2024/09/05.
//

import SwiftUI

@main
struct UserDefaultsKeyMacroSampleApp: App {        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 600, height: 600)
                .onDisappear {
                    NSApplication.shared.terminate(self)  // メインのウインドウが閉じたときにAppを終了させる
                }
        }
    }
}
