//
//  Exercise_deletion.swift
//  Progression
//
//  Created by Jesper Bertelsen on 22/05/2022.
//

import SwiftUI

struct Exercise_deletion: View {
    var onConfirm: () -> Void
    var onDeny: () -> Void
    @Binding var isActive: Bool
    var body: some View {
        InteractionView(isActive: $isActive) {
            HStack {
                Button {
                    onConfirm()
                } label: {
                    button(true)
                }
                Button {
                    onDeny()
                } label: {
                    button(false)
                }
            }
        }
    }
    func button(_ confirm: Bool) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.accentColor).opacity(0.2)
            .overlay(
                Text(confirm ? "Yes" : "No")
                    .font(.title2)
                    .foregroundColor(.black)
            )
    }
}
