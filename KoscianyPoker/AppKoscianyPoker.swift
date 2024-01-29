import SwiftUI

@main
struct AppKoscianyPoker: App {
    @StateObject var game = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
