//
//  GlowingText.swift
//  print app
//
//  Created by 李璟寬 on 2025/10/3.
//

import SwiftUI

struct GlowingText: View {
    let text: String
    let color: Color
    let glowColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 36, weight: .bold))
            .foregroundStyle(color)
            .shadow(color: glowColor.opacity(0.7), radius: 15)
            .shadow(color: glowColor.opacity(0.7), radius: 5)
    }
}
