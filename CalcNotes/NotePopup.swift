//
//  NotePopup.swift
//  CalcNotes
//
//  Created by Kuldeep singh on 24/08/25.
//


import SwiftUI

struct NotePopup: View {
    @Binding var noteText: String
    var onSave: () -> Void
    var onSkip: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "pencil.and.outline")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text("Add Note")
                .font(.headline)
            
            TextField("Enter note...", text: $noteText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Button("Skip") {
                    onSkip()
                }
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    onSave()
                }
                .foregroundColor(.blue)
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(width: 280)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 10)
        .transition(.scale.combined(with: .opacity))
    }
}
