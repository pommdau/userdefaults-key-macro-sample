# userdefaults-key-macro-sample

This is the sample project of [pommdau/userdefaults\-key\-macro](https://github.com/pommdau/userdefaults-key-macro/tree/main)

<img width="712" alt="image" src="https://github.com/user-attachments/assets/db5b544a-eb9b-455b-908d-f797fdb0f63e">

## Expand Macro of `@AddUserDefaultsKey`

Source code:

```swift
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
```

Expanded source:

```swift
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
    enum UserDefaultsKey: String, CaseIterable {
        case count = "ContentView_count"
        case color = "ContentView_color"
    }

    func reset(of key: UserDefaultsKey) {
        switch key {
        case .count:
            count = 40
        case .color:
            color = .blue
        }
    }
}
```



