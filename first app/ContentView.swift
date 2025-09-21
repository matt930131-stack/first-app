import SwiftUI
import AVFoundation

// 棋格狀態
enum Cell: Int, Codable {
    case empty = 0
    case black = 1
    case white = 2
    
    var color: Color? {
        switch self {
        case .black: return .black
        case .white: return .white
        case .empty: return nil
        }
    }
}

// 一步棋記錄
struct Move: Codable {
    let x: Int
    let y: Int
    let player: Cell
}

struct ContentView: View {
    private let size = 15
    private let winCount = 5
    
    // 遊戲狀態
    @State private var gameStarted = false
    @State private var board: [Cell]
    @State private var currentPlayer: Cell? = nil
    @State private var winner: Cell? = nil
    @State private var moves: [Move] = []
    @State private var winLine: [(Int, Int)] = []
    
    // 骰子系統
    @State private var blackDice: [Int] = [0, 0]
    @State private var whiteDice: [Int] = [0, 0]
    @State private var blackRolled = false
    @State private var whiteRolled = false
    @State private var needRollDice = true
    
    // 音樂播放器
    @State private var bgmPlayer: AVAudioPlayer?
    @State private var sfxPlayer: AVAudioPlayer?
    
    @State private var showWinAlert = false
    @State private var showRule = false
    
    init() {
        _board = State(initialValue: Array(repeating: .empty, count: 15 * 15))
    }
    
    var body: some View {
        VStack {
            if !gameStarted {
                Button(action: {
                    gameStarted = true
                    playBGM(name: "bgm", type: "mp3")
                }) {
                    Text("開始遊戲")
                        .font(.largeTitle).bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            } else {
                VStack(spacing: 12) {
                    header
                    
                    HStack {
                        Spacer()
                        Button("📖 規則說明") {
                            showRule = true
                        }
                        .padding(.trailing)
                    }
                    
                    if needRollDice {
                        diceView
                    } else {
                        boardView
                        controlBar
                    }
                }
                .padding()
                // 📖 規則面板
                .sheet(isPresented: $showRule) {
                    VStack(spacing: 20) {
                        Text("🎲 五子棋骰子版規則")
                            .font(.title).bold()
                        Text("""
                        1. 每回合開始前，黑棋與白棋各擲兩顆骰子。
                        2. 點數總和大的一方獲得先手。
                        3. 若點數相同，自動重新擲骰子。
                        4. 先手玩家落子後，再換另一方。
                        5. 其他規則與一般五子棋相同。
                        """)
                        .multilineTextAlignment(.leading)
                        .padding()
                        Button("關閉") {
                            showRule = false
                        }
                        .padding()
                    }
                }
                // 🎉 勝利彈窗
                .alert(isPresented: $showWinAlert) {
                    Alert(
                        title: Text("🎉 遊戲結束"),
                        message: Text("\(winner == .black ? "⚫️ 黑棋" : "⚪️ 白棋") 獲勝！"),
                        dismissButton: .default(Text("重新開始")) {
                            reset()
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Header
    private var header: some View {
        HStack {
            if let w = winner {
                Text("\(w == .black ? "⚫️ 黑" : "⚪️ 白") 獲勝！")
                    .font(.title2).bold()
                    .foregroundStyle(w == .black ? .black : .gray)
            } else if let p = currentPlayer {
                Text("輪到：\(p == .black ? "⚫️ 黑" : "⚪️ 白")")
                    .font(.title2).bold()
                    .foregroundStyle(p == .black ? .black : .gray)
            } else {
                Text("請擲骰子決定先手")
                    .font(.title2).bold()
            }
            Spacer()
        }
    }
    
    // MARK: - 骰子畫面 (含 cash, dice 貼圖 + 粉紅框 + 陰影)
    private var diceView: some View {
        VStack(spacing: 20) {
            // 上方 Cash 貼圖
            Image("cash")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            // 中間骰子對戰區，加上精美長方形框
            VStack(spacing: 20) {
                Text("擲骰子決定誰先下")
                    .font(.title2).bold()
                
                HStack(spacing: 40) {
                    VStack {
                        Text("⚫️ 黑棋").bold()
                        Text("\(blackDice[0]) \(blackDice[1])")
                            .font(.largeTitle).bold()
                        Button("黑棋擲骰子") {
                            blackDice = [Int.random(in: 1...6), Int.random(in: 1...6)]
                            blackRolled = true
                            playSFX(name: "dice", type: "mp3")
                            checkBothRolled()
                        }
                        .disabled(blackRolled)
                    }
                    VStack {
                        Text("⚪️ 白棋").bold()
                        Text("\(whiteDice[0]) \(whiteDice[1])")
                            .font(.largeTitle).bold()
                        Button("白棋擲骰子") {
                            whiteDice = [Int.random(in: 1...6), Int.random(in: 1...6)]
                            whiteRolled = true
                            playSFX(name: "dice", type: "mp3")
                            checkBothRolled()
                        }
                        .disabled(whiteRolled)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.pink, lineWidth: 4)   // 粉紅色外框
                    .shadow(radius: 10)                 // 陰影
            )
            
            // 下方 Dice 貼圖
            Image("dice")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
    
    // MARK: - 棋盤
    private var boardView: some View {
        GeometryReader { geo in
            let side = min(geo.size.width, geo.size.height)
            let cellSide = side / CGFloat(size)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 0.95, green: 0.90, blue: 0.78))
                
                // 棋盤格線
                Canvas { ctx, _ in
                    let step = side / CGFloat(size)
                    var path = Path()
                    for i in 0..<size {
                        let offset = CGFloat(i) * step + step/2
                        path.move(to: CGPoint(x: offset, y: step/2))
                        path.addLine(to: CGPoint(x: offset, y: side - step/2))
                        path.move(to: CGPoint(x: step/2, y: offset))
                        path.addLine(to: CGPoint(x: side - step/2, y: offset))
                    }
                    ctx.stroke(path, with: .color(.brown.opacity(0.6)), lineWidth: 1)
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(cellSide), spacing: 0), count: size), spacing: 0) {
                    ForEach(0 ..< size*size, id: \.self) { idx in
                        let x = idx % size
                        let y = idx / size
                        ZStack {
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture { place(x: x, y: y) }
                            
                            if let c = board[idx].color {
                                Circle()
                                    .fill(c)
                                    .padding(cellSide * 0.18)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.red, lineWidth: winLine.contains(where: { $0.0 == x && $0.1 == y }) ? 3 : 0)
                                    )
                                    .shadow(radius: c == .black ? 2 : 0)
                            }
                        }
                        .frame(width: cellSide, height: cellSide)
                    }
                }
                .frame(width: side, height: side)
            }
            .frame(width: side, height: side)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    // MARK: - 控制列
    private var controlBar: some View {
        HStack(spacing: 12) {
            Button {
                undo()
            } label: {
                Label("悔棋", systemImage: "arrow.uturn.backward")
            }
            .disabled(moves.isEmpty || winner != nil)
            
            Button {
                reset()
            } label: {
                Label("重新開始", systemImage: "gobackward")
            }
            
            Spacer()
        }
        .buttonStyle(.borderedProminent)
    }
    
    // MARK: - 遊戲邏輯
    private func index(_ x: Int, _ y: Int) -> Int { y * size + x }
    
    private func place(x: Int, y: Int) {
        guard winner == nil else { return }
        guard let p = currentPlayer else { return }
        
        let i = index(x, y)
        guard board[i] == .empty else { return }
        
        board[i] = p
        moves.append(Move(x: x, y: y, player: p))
        
        playSFX(name: "click", type: "wav")
        
        if checkWin(fromX: x, y: y, player: p) {
            winner = p
            bgmPlayer?.stop()
            playSFX(name: "win", type: "mp3")
            showWinAlert = true
            return
        }
        
        currentPlayer = (p == .black) ? .white : .black
        
        if moves.count % 2 == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                needRollDice = true
                currentPlayer = nil
                blackRolled = false
                whiteRolled = false
                blackDice = [0,0]
                whiteDice = [0,0]
            }
        }
    }
    
    private func reset() {
        board = Array(repeating: .empty, count: size * size)
        currentPlayer = nil
        winner = nil
        moves.removeAll()
        winLine.removeAll()
        showWinAlert = false
        needRollDice = true
        blackRolled = false
        whiteRolled = false
        blackDice = [0,0]
        whiteDice = [0,0]
        
        bgmPlayer?.stop()
        playBGM(name: "bgm", type: "mp3")
    }
    
    private func undo() {
        guard let last = moves.popLast(), winner == nil else { return }
        board[index(last.x, last.y)] = .empty
        currentPlayer = last.player
    }
    
    private let directions = [(1,0), (0,1), (1,1), (1,-1)]
    
    private func checkWin(fromX x: Int, y: Int, player: Cell) -> Bool {
        for d in directions {
            var coords = [(x,y)]
            coords += runCoords(x: x, y: y, dx: d.0, dy: d.1, player: player)
            coords += runCoords(x: x, y: y, dx: -d.0, dy: -d.1, player: player)
            
            if coords.count >= winCount {
                winLine = Array(coords.prefix(winCount))
                return true
            }
        }
        return false
    }
    
    private func runCoords(x: Int, y: Int, dx: Int, dy: Int, player: Cell) -> [(Int,Int)] {
        var result: [(Int,Int)] = []
        var cx = x + dx
        var cy = y + dy
        while cx >= 0, cx < size, cy >= 0, cy < size, board[index(cx, cy)] == player {
            result.append((cx, cy))
            cx += dx
            cy += dy
        }
        return result
    }
    
    // MARK: - 擲骰子邏輯
    private func checkBothRolled() {
        if blackRolled && whiteRolled {
            let blackSum = blackDice[0] + blackDice[1]
            let whiteSum = whiteDice[0] + whiteDice[1]
            
            sfxPlayer?.stop() // 停止骰子音效
            
            if blackSum > whiteSum {
                currentPlayer = .black
            } else if whiteSum > blackSum {
                currentPlayer = .white
            } else {
                // 平手 → 自動重擲
                blackDice = [Int.random(in: 1...6), Int.random(in: 1...6)]
                whiteDice = [Int.random(in: 1...6), Int.random(in: 1...6)]
                playSFX(name: "dice", type: "mp3")
                checkBothRolled()
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                needRollDice = false
            }
        }
    }
    
    // MARK: - 音效 / 音樂
    private func playBGM(name: String, type: String) {
        bgmPlayer?.stop()
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            do {
                bgmPlayer = try AVAudioPlayer(contentsOf: url)
                bgmPlayer?.numberOfLoops = -1
                bgmPlayer?.volume = 1.0
                bgmPlayer?.prepareToPlay()
                bgmPlayer?.play()
            } catch {
                print("無法播放背景音樂: \(error)")
            }
        } else {
            print("⚠️ 找不到背景音樂檔案：\(name).\(type)")
        }
    }
    
    private func playSFX(name: String, type: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            do {
                sfxPlayer = try AVAudioPlayer(contentsOf: url)
                sfxPlayer?.prepareToPlay()
                sfxPlayer?.currentTime = 0
                sfxPlayer?.play()
            } catch {
                print("無法播放音效: \(error)")
            }
        } else {
            print("⚠️ 找不到音效檔案：\(name).\(type)")
        }
    }
}
