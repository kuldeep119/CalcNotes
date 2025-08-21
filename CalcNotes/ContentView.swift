//
//  ContentView.swift
//  CalcNotes
//
//  Created by Kuldeep singh on 26/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var currentOperation: String? = nil
    @State private var firstNumber: Double? = nil
    @State private var History: [String] = []
    
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
                        History.removeAll()
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                }
                .padding(.horizontal)
                
                // ✅ History list with delete
                List {
                    ForEach(History.reversed(), id: \.self) { entry in
                        Text(entry)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(6)
                    }
                    .onDelete(perform: deleteHistory)
                }
                .frame(height: 180)
                
                // ✅ Calculator display
                Text(display)
                    .font(.system(size: 48))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(20)
                
                // ✅ Calculator buttons
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        CalcButton(title: "AC", backgroundColor: .orange) { clearTapped() }
                        CalcButton(title: "=", backgroundColor: .orange) { equalsTapped() }
                        CalcButton(title: "⌫", backgroundColor: .red) { backspaceTapped() }
                        CalcButton(title: "÷", backgroundColor: .gray) { operationTapped("/") }
                    }
                    HStack(spacing: 16) {
                        CalcButton(title: "7", backgroundColor: .gray) { numberTapped("7") }
                        CalcButton(title: "8", backgroundColor: .gray) { numberTapped("8") }
                        CalcButton(title: "9", backgroundColor: .gray) { numberTapped("9") }
                        CalcButton(title: "*", backgroundColor: .gray) { operationTapped("*") }
                    }
                    HStack(spacing: 16) {
                        CalcButton(title: "4", backgroundColor: .gray) { numberTapped("4") }
                        CalcButton(title: "5", backgroundColor: .gray) { numberTapped("5") }
                        CalcButton(title: "6", backgroundColor: .gray) { numberTapped("6") }
                        CalcButton(title: "-", backgroundColor: .gray) { operationTapped("-") }
                    }
                    HStack(spacing: 16) {
                        CalcButton(title: "1", backgroundColor: .gray) { numberTapped("1") }
                        CalcButton(title: "2", backgroundColor: .gray) { numberTapped("2") }
                        CalcButton(title: "3", backgroundColor: .gray) { numberTapped("3") }
                        CalcButton(title: "+", backgroundColor: .gray) { operationTapped("+") }
                    }
                    HStack(spacing:16) {
                        CalcButton(title: "", backgroundColor: .gray) { }
                        CalcButton(title: "0", backgroundColor: .gray){ numberTapped("0") }
                        CalcButton(title: ".", backgroundColor: .gray) { numberTapped(".") }
                        CalcButton(title: " ", backgroundColor: .gray) { }
                    }
                }
                .padding(.bottom)
            }
            .padding()
            
            // ✅ Popup Alert style
            if showNotePrompt {
                VStack(spacing: 15) {
                    Image(systemName: "pencil.and.outline")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                    Text("Add Note")
                        .font(.headline)
                    
                    TextField("Enter note...", text: $noteText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.black)
                        .padding(.horizontal)
                        
                    
                    HStack {
                        Button("Skip") {
                            withAnimation {
                                saveNote(skip: true)   // ✅ save directly
                                showNotePrompt = false
                            }
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button("Save") {
                            withAnimation {
                                saveNote(skip: false)  // ✅ save with note
                                showNotePrompt = false
                            }
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
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showNotePrompt)
    }
    
    // MARK: - Functions
    func deleteHistory(at offsets: IndexSet) {
        
        let reversedOffsets = offsets.map { History.count - 1 - $0 }
        for index in reversedOffsets {
            History.remove(at: index)
        }
    }
    
    func numberTapped(_ number: String) {
        if display == "0" || display == "-0" {
            display = number
        }else if let last = display.last, "+-*÷".contains(last){
            display += number
        }
        else{
            display += number
        }
    }
    
    
    func operationTapped(_ operation: String) {
        if let last = display.last, "+-*/".contains(last) {
               display.removeLast()
            display.append(operation)
           }
           display += " \(operation) "
           currentOperation = operation
       }
    
    
    func equalsTapped() {
    
//        let parts = display.split(separator: " ")
//            guard parts.count == 3,
//                  let first = Double(parts[0]),
//                  let second = Double(parts[2]) else { return }
//
//        let op = String(parts[1])
//        var result: Double = 0
//
//        switch op {
//        case "+": result = first + second
//        case "-": result = first - second
//        case "/": result = second != 0 ? first / second : 0
//        case "*": result = first * second
//        default: break
//        }
//
        let expression = display.replacingOccurrences(of: "÷", with: "/")
            let exp = NSExpression(format: expression)
            
            if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
        
                let resultString = String(result.doubleValue.clean())
           pendingEntry = "\(display) = \(resultString)"
           display = resultString
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               withAnimation {
                   showNotePrompt = true
                   noteText = " "
               }
           }
        }
    }
    
    func saveNote(skip: Bool = false) {
        if skip {
            History.append(pendingEntry)
        } else {
            History.append("\(pendingEntry)  [\(noteText)]")
        }

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



// MARK: - Helpers
extension Double {
    func clean() -> String {
        return truncatingRemainder(dividingBy: 1) == 0 ?
            String(format: "%.0f", self) :
            String(format: "%.2f", self)
    }
}




struct CalcButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title)
                .frame(width: 70, height: 70)
                .background(backgroundColor)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
