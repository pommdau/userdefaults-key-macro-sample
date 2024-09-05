//
//  ContentView.swift
//  UserDefaultsKeyMacroSample
//
//  Created by HIROKI IKEUCHI on 2024/09/05.
//

import SwiftUI
import UserDefaultsKey

@AddUserDefaultsKey
struct ContentView: View {
    
    @AppStorage(UserDefaultsKey.count.rawValue)
    private var count: Int = 40
    
    @AppStorage(UserDefaultsKey.color.rawValue)
    private var color: Color = .blue
        
    var body: some View {
        VStack {
            Form {
                settingsResultSection()
                settingsSection()
                userDefaultsPlistSection()                            
            }
            .formStyle(.grouped)
        }
    }
}

// MARK: - Helpers

extension ContentView {
    
    // MARK: - Computed Properties
    
    private var userDefaultsPlist: URL? {
        guard
            let library = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first,
            let bundleIdentifier = Bundle.main.bundleIdentifier
        else {
            return nil
        }
        return library
            .appendingPathComponent("Preferences")
            .appendingPathComponent(bundleIdentifier)
            .appendingPathExtension("plist")
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private func settingsResultSection() -> some View {
        Section("Settings Result") {
            LabeledContent("") {
                Text("Count: \(count)")
                    .foregroundStyle(color)
                    .monospaced()
            }
        }
    }
    
    @ViewBuilder
    private func settingsSection() -> some View {
        Section("Settings") {
            LabeledContent("Count") {
                Button {
                    count -= 1
                } label: {
                    Text("-")
                        .frame(width: 30)
                }
                Button {
                    count += 1
                } label: {
                    Text("+")
                        .frame(width: 30)
                }
            }
            LabeledContent("") {
                Button("Reset") {
                    // added by @AddUserDefaultsKey
                    reset(of: .count)
                }
            }
            
            LabeledContent("Color") {
                ColorPicker("", selection: $color)
            }
            LabeledContent("") {
                Button("Reset") {
                    // added by @AddUserDefaultsKey
                    reset(of: .color)
                }
            }
        }
    }
    
    @ViewBuilder
    private func userDefaultsPlistSection() -> some View {
        Section("UserDefaults Plist") {
            LabeledContent("Reset UserDefaults All") {
                Button("Reset") {
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                }
            }
            
            LabeledContent("Show UserDefaults-Plist") {
                Button("Show in Finder") {
                    guard let url = userDefaultsPlist else {
                        return
                    }
                    NSWorkspace.shared.selectFile(url.path, inFileViewerRootedAtPath: url.deletingLastPathComponent().path)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
