//
//  ContentView.swift
//  CalcNotes
//
//  Created by Kuldeep singh on 26/07/25.
//

//
//  ContentView.swift
//  CalcNotes
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var currentOperation: String? = nil
    @State private var firstNumber: Double? = nil
    @State private var history: [String] = []
    
    @State private var showNotePrompt = false
    @State private var noteText = ""
    @State private var pendingEntry = ""
    @State private var message = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                // ✅ History Header
                HStack {
                    Text("History")
                        .font(.headline)
                    Spacer()
                    Button("Clear History") {
                        history.removeAll()
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                }
                .padding(.horizontal)
                
                // ✅ History list
                List {
                    ForEach(history.reversed(), id: \.self) { entry in
                        Text(entry)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(6)
                    }
                    .onDelete(perform: deleteHistory)
                }
                .frame(height: 180)
                
                // ✅ Calculator Display
                Text(display)
                    .font(.system(size: 48))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(20)
                
                // ✅ Calculator Buttons Grid
                CalculatorButtonsView(
                    numberTapped: numberTapped,
                    operationTapped: operationTapped,
                    equalsTapped: equalsTapped,
                    clearTapped: clearTapped,
                    backspaceTapped: backspaceTapped
                )
            }
            .padding()
            
            if showNotePrompt {
                NotePopup(
                    noteText: $noteText,
                    onSave: {
                        saveNote(skip: false)
                    },
                    onSkip: {
                        saveNote(skip: true) 
                    }
                )
                .zIndex(1)
            }
         }
        .animation(.easeInOut, value: showNotePrompt)
    }
}

// MARK: - Functions
extension ContentView {
    func deleteHistory(at offsets: IndexSet) {
        let reversedOffsets = offsets.map { history.count - 1 - $0 }
        for index in reversedOffsets {
            history.remove(at: index)
        }
    }
    
    func numberTapped(_ number: String) {
        display = CalculatorLogic.numberTapped(current: display, number: number)
    }
    
    func operationTapped(_ operation: String) {
        display = CalculatorLogic.operationTapped(current: display, operation: operation)
        currentOperation = operation
    }
    
    func equalsTapped() {
        if let resultString = CalculatorLogic.equalsTapped(display: display) {
            pendingEntry = "\(display) = \(resultString)"
            display = resultString
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showNotePrompt = true
                    noteText = ""
                }
            }
        }
    }
    
    func saveNote(skip: Bool = false) {
        if skip {
            history.append(pendingEntry)
        } else {
            history.append("\(pendingEntry)  [\(noteText)]")
        }
        showNotePrompt = false
    }
    
    func clearTapped() {
        display = "0"
        firstNumber = nil
        currentOperation = nil
    }
    
    func backspaceTapped() {
        if display.count > 1 {
            display.removeLast()
        } else {
            display = "0"
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
