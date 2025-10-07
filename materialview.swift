import SwiftUI

// 資料結構
struct Material: Identifiable {
    let id = UUID()
    let img: String
    let title: String
    let desc: String
    let url: String
}

struct MaterialView: View {
    // 材料資料
    let materials: [Material] = [
        Material(
            img: "pla",
            title: "PLA",
            desc: "入門好上手、氣味低，但韌性較差。",
            url: "https://3dmart.com.tw/news/figure-out-of-pla-3d-printing-materials"
        ),
        Material(
            img: "abs",
            title: "ABS",
            desc: "強度高、耐衝擊，列印需加熱床，容易翹曲。",
            url: "https://3dmart.com.tw/news/abs-vs-pc-filaments-comparedbs"
        ),
        Material(
            img: "petg",
            title: "PETG",
            desc: "韌性好、耐化學性，介於 PLA 與 ABS 之間。",
            url: "https://3dmart.com.tw/shop/polylite-petg-series"
        ),
        Material(
            img: "tpu",
            title: "TPU",
            desc: "可彎曲的彈性材料，需降低速度與好導軸。",
            url: "https://3dmart.com.tw/news/flexible-3d-print-3d-models"
        ),
        Material(
            img: "pa",
            title: "PA(尼龍)",
            desc: "耐磨耐用、吸濕性高，通常需特殊封閉環境。",
            url: "https://3dmart.com.tw/shop/bambulab-pa6-cf-filament-black"
        )
    ]
    
    // 畫面
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(materials) { m in
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .frame(width: 350, height: 140)
                            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 3)
                        
                        
                        HStack(spacing: 12) {
                            
                            Image(m.img)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                           
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Link(destination: URL(string: m.url)!) {
                                    Text(m.title)
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                                
                                Text(m.desc)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
    }
}
#Preview {
    MaterialView()
}
