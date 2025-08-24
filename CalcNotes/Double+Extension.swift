//
//  Double+Extension.swift
//  CalcNotes
//
//  Created by Kuldeep singh on 24/08/25.
//


import Foundation

extension Double {
    func clean() -> String {
        return truncatingRemainder(dividingBy: 1) == 0 ?
            String(format: "%.0f", self) :
            String(format: "%.2f", self)
    }
}
