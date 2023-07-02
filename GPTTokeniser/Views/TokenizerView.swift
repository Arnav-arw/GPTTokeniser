//
//  TokenizerView.swift
//  GPTTokeniser
//
//  Created by Arnav Singhal on 02/07/23.
//

import SwiftUI

public struct TokenizerView: View {
    
    @StateObject var vm = TokenizerViewModel()
    @FocusState private var isFocused: Bool
    
    public init() {
        self._vm = .init(wrappedValue: .init())
        self.isFocused = false
    }
    
    public var body: some View {
        List {
            inputSection
            outputSection
        }
        .navigationTitle("GPT Tokenizer")
    }
    
    var inputSection: some View {
        Section {
            TextField("Enter text to tokenize", text: $vm.inputText, axis: .vertical)
                .focused($isFocused)
                .lineLimit(4...12)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") {
                                isFocused = false
                            }
                        }
                    }
                }
            
            HStack {
                Button("Clear") {
                    withAnimation {
                        vm.inputText = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.inputText.isEmpty)
                
                Spacer()
                
                if vm.isTokenizing {
                    ProgressView()
                }
                
            }
            .padding(.vertical, 2)
        } header: {
            Text("Input")
        }
        
    }
    
    var outputSection: some View {
        Section {
            if let output = vm.output {
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            Text("Tokens").font(.subheadline)
                            Text("\(output.tokens.count)").font(.headline)
                        }
                        
                        Divider()
                            .frame(height: 32)
                        
                        VStack {
                            Text("Characters").font(.subheadline)
                            Text("\(output.text.count)").font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Picker("Output Type", selection: $vm.outputType) {
                        Text("Text").tag(OutputType.text)
                        Text("Token Ids").tag(OutputType.tokenIds)
                    }
                    .pickerStyle(.segmented)
                    
                    switch vm.outputType {
                    case .text:
                        TextView(output: output)
                            .frame(height: 240)
                        
                    case .tokenIds:
                        Text("\(output.tokens.description)")
                            .textSelection(.enabled)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical)
                    }
                }
            }
        } header: {
            if vm.output != nil {
                Text("Output")
            }
        } footer: {
            
        }
    }
}

struct TokenizerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TokenizerView()
        }
    }
}
