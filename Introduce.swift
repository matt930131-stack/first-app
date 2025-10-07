import SwiftUI

struct Introduce: View {
    var body: some View {
        ZStack {
            // === 外層背景與邊框 ===
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 10, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 10)

           
            TabView {
                // ===== Page 1 =====
                VStack(alignment: .leading, spacing: 14) {
                    Image("fdm1")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 320)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.8), lineWidth: 1)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 6)

                    Text("FDM 技術的誕生與理念")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .green, radius: 1, x: 2, y: 2)

                    Text("**熔融沉積成型（FDM）讓「層層堆疊、自由成形」成為可能。只需一卷線材與一台列印機，設計能快速從數位模型走到實體作品，讓創造力不再受制於模具與傳統加工。**")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)

                // ===== Page 2 =====
                VStack(alignment: .leading, spacing: 14) {
                    Image("fdm2")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 320)
                        .clipped()
                        .overlay(
                            LinearGradient(colors: [.clear, .black.opacity(0.12)],
                                           startPoint: .top, endPoint: .bottom)
                                .cornerRadius(16)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 6)

                    Text("創新與智慧製造的啟發")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.purple)
                        .shadow(color: .blue, radius: 1, x: 2, y: 2)

                    Text("**FDM 不只是工具，更是把靈感變成實體的橋樑。結合 AI 與參數優化，機台能偵測錯層與溫度波動，讓創意實現更穩定、品質更可控。**")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)

                // ===== Page 3 =====
                VStack(alignment: .leading, spacing: 14) {
                    Image("fdm3")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 320)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.15), lineWidth: 2)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 6)

                    Text("熔融沉積的運作原理")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.red)
                        .shadow(color: .yellow, radius: 1, x: 2, y: 2)

                    Text("**線材由線軸進入加熱噴嘴後熔融，依 G-code 路徑精準擠出並層層冷卻固化成形。不同材料（PLA、ABS、PETG…）須搭配對應溫度與風道設定，才能得到穩定品質。**")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)

                // ===== Page 4 =====
                VStack(alignment: .leading, spacing: 14) {
                    Group {
                        Image("fdm4")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth:300, minHeight: 260, maxHeight: 320)
                            .clipped()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.orange.opacity(0.2), lineWidth: 2)
                            )
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.08), radius: 10, y: 6)
                    }

                    Text("精密列印的核心：噴頭與控制")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.pink)
                        .shadow(color: .black, radius: 1, x: 2, y: 2)

                    Text("**噴頭需同時兼顧穩定加熱與精準輸出。現代機台以熱敏感應、風扇冷卻與步進馬達控制協作，層厚誤差可縮小至 0.05 mm 以內，使邊緣更平滑、結構更緊密。**")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                

                // ===== Page 5 =====
                VStack(alignment: .leading, spacing: 14) {
                    Image("fdm5")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 320)
                        .clipped()
                        .overlay(
                            LinearGradient(colors: [.black.opacity(0.08), .clear],
                                           startPoint: .top, endPoint: .bottom)
                                .cornerRadius(16)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 6)

                    Text("現況與未來：普及與高性能材料")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.gray)
                        .shadow(color: .black, radius: 1, x: 2, y: 2)

                    Text("**FDM 已遍佈教育、創客、汽車與醫療等領域，用於快速原型與功能性零件。隨著導電、纖維增強與可回收材料成熟，FDM 正朝向高性能與永續製造前進。**")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .background(Color(.systemGroupedBackground))
            .cornerRadius(24)
        }
        .padding()
    }
}

#Preview {
    Introduce()
}
