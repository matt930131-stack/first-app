import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // 背景圖（滿版，不影響捲動內容）
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // 主要內容：垂直捲動
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 16) {

                    // 顯示主標（保留你的特效與寫法）
                    GlowingText(text: "FDM 操作指南", color: .white, glowColor: .yellow)
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.white.opacity(0.9)))
                        .shadow(radius: 1)
                        .padding(.top, 8)

                    // 你原本的三個分段（不更動順序與名稱）
                    MaterialView()
                    function()

                    // TabView 所在的副程式（關鍵：給固定高度，避免被 ScrollView 切版）
                    Introduce()
                        .frame(height: 520)    // ← 這行是重點，數值可依需要微調

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32) // 讓內容不被下方 Home 指示列擋到
            }
        }
        // 與動態島 / Home 指示列保持安全距
        .safeAreaPadding(.top, 16)
        .safeAreaPadding(.bottom, 24)
    }
}

#Preview {
    ContentView()
}
