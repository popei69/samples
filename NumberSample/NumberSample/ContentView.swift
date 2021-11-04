//
//  ContentView.swift
//  NumberSample
//
//  Created by Benoit PASQUIER on 28/10/2021.
//

import SwiftUI
import Combine

protocol NumberFormatterProtocol: AnyObject {
    func string(from number: NSNumber) -> String?
    func string(for obj: Any?) -> String?
    var numberStyle: NumberFormatter.Style { get set }
    var maximumFractionDigits: Int { get set }
}

extension NumberFormatter: NumberFormatterProtocol { }

class PreviewNumberFormatter: NumberFormatterProtocol {
    
    let numberFormatter: NumberFormatter
    
    init(locale: Locale) {
        numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
    }
    
    var numberStyle: NumberFormatter.Style {
        get {
            return numberFormatter.numberStyle
        }
        set {
            numberFormatter.numberStyle = newValue
        }
    }
    
    var maximumFractionDigits: Int {
        get {
            return numberFormatter.maximumFractionDigits
        }
        set {
            numberFormatter.maximumFractionDigits = newValue
        }
    }
    
    func string(from number: NSNumber) -> String? {
        return numberFormatter.string(from: number)
    }
    
    func string(for obj: Any?) -> String? {
        numberFormatter.string(for: obj)
    }
}

struct ContentView: View {
    @State private var isSubtitleHidden = false
    @State private var value = 10
    
    private var numberFormatter: NumberFormatterProtocol
    
    init(numberFormatter: NumberFormatterProtocol = NumberFormatter()) {
        self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.maximumFractionDigits = 2
    }

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Send money")
                .font(.title)
            
            CurrencyTextField(numberFormatter: numberFormatter, value: $value)
                .padding(20)
                .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                .frame(height: 100)
            
            Rectangle()
                .frame(width: 0, height: 40)
            
            Text("Send")
                .fontWeight(.bold)
                .padding(30)
                .frame(width: 180, height: 50)
                .background(Color.yellow)
                .cornerRadius(20)
                .onTapGesture {
                    if !isSubtitleHidden {
                        isSubtitleHidden.toggle()
                    }
                }
                
                
            if isSubtitleHidden {
                Text("Sending \(value)")
            }
            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(numberFormatter: 
                        PreviewNumberFormatter(locale: Locale(identifier: "en_GB"))
        )
    }
}

struct CurrencyTextField: UIViewRepresentable {
    
    typealias UIViewType = CurrencyUITextField
    
    let numberFormatter: NumberFormatterProtocol
    let currencyField: CurrencyUITextField
    
    init(numberFormatter: NumberFormatterProtocol, value: Binding<Int>) {
        self.numberFormatter = numberFormatter 
        currencyField = CurrencyUITextField(formatter: numberFormatter, value: value)
    }
    
    func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }
    
    func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}

class CurrencyUITextField: UITextField {
    @Binding private var value: Int
    private let formatter: NumberFormatterProtocol
    
    init(formatter: NumberFormatterProtocol, value: Binding<Int>) {
        self.formatter = formatter
        self._value = value
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        text = textValue.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    
    private func setupViews() {
        tintColor = .clear
        font = .systemFont(ofSize: 40, weight: .regular)
    }
    
    @objc private func editingChanged() {
        text = currency(from: decimal)
        resetSelection()
        value = Int(doubleValue * 100)
    }
    
    @objc private func resetSelection() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
    
    private var textValue: String {
        return text ?? ""
    }

    private var doubleValue: Double { 
      return (decimal as NSDecimalNumber).doubleValue 
    }

    private var decimal: Decimal { 
      return textValue.decimal / pow(10, formatter.maximumFractionDigits) 
    }
    
    private func currency(from decimal: Decimal) -> String { 
        return formatter.string(for: decimal) ?? ""
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}

extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
