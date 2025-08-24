//
//  CalcButton.swift
//  CalcNotes
//
//  Created by Kuldeep singh on 24/08/25.


import SwiftUI

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

struct CalculatorButtonsView: View {
    let numberTapped: (String) -> Void
    let operationTapped: (String) -> Void
    let equalsTapped: () -> Void
    let clearTapped: () -> Void
    let backspaceTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                CalcButton(title: "AC", backgroundColor: .orange, action: clearTapped)
                CalcButton(title: "=", backgroundColor: .orange, action: equalsTapped)
                CalcButton(title: "⌫", backgroundColor: .red, action: backspaceTapped)
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
                CalcButton(title: "0", backgroundColor: .gray) { numberTapped("0") }
                CalcButton(title: ".", backgroundColor: .gray) { numberTapped(".") }
                CalcButton(title: " ", backgroundColor: .gray) { }
            }
        }
        .padding(.bottom)
    }
}
