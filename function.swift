import SwiftUI

struct function: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            ZStack{
                RoundedRectangle(cornerRadius: 22).fill(.yellow)
                Text("操作手冊")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            }
            .frame(height: 12)
            .frame(maxWidth: .infinity)
            ZStack {
                
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.99, green: 0.95, blue: 0.98), // very light pink
                                Color(red: 0.94, green: 0.97, blue: 1.00)  // very light blue
                            ],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(.white.opacity(0.6), lineWidth: 0.5)
                    )
                    .shadow(color: .black.opacity(0.06), radius: 14, y: 10)
                    .frame(height: 220)
                    .padding(.horizontal, 20)
                
                
                HStack(spacing: 24) {
                    VStack(spacing: 10) {
                        Image("bed")                 // Assets 名稱
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.yellow, lineWidth: 3))
                            .shadow(color: Color.yellow.opacity(0.25), radius: 6, y: 3)
                        
                        Text("[加熱床](https://jamespolik.pixnet.net/blog/post/347609547)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.28)) // 深灰
                        
                    }
                        // 2. 噴頭溫度
                        VStack(spacing: 10) {
                            Text("[噴頭溫度](https://www.photonier3d.com/blogs/%E8%B7%AF%E5%BE%91%E9%96%8B%E6%95%99/%E8%B7%AF%E5%BE%91%E8%A7%A3%E8%AA%AA-1)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.28))
                            Image("head")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.green, lineWidth: 3))
                                .shadow(color: Color.green.opacity(0.25), radius: 6, y: 3)
                            
                            
                         
                        }
                        
                        // 3. 列印時間
                        VStack(spacing: 10) {
                            Image("time")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                                .shadow(color: Color.blue.opacity(0.25), radius: 6, y: 3)
                            
                            Text("[列印時間](https://3dmart.com.tw/en/news/why-is-3d-printing-so-slow)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.28))
                           
                        }
                        
                        // 4. 天氣影響
                        VStack(spacing: 10) {
                            Text("[天氣影響](https://www.reddit.com/r/3Dprinting/comments/17p6tg4/how_sensitive_is_3d_printing_to_ambient/?tl=zh-hant)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color(red: 0.22, green: 0.24, blue: 0.28))
                            Image("tempeture")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.cyan, lineWidth: 3))
                                .shadow(color: Color.cyan.opacity(0.25), radius: 6, y: 3)
                            
                           
                            
                        }
                    }
                    .padding(.horizontal, 36)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                LinearGradient(colors: [.white, Color(.systemGray6)],
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            )
        }
        
    }

#Preview {
    function()
}
