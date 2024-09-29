//
//  ChatPage.swift
//  HackatonProject
//
//  Created by Xerco Tchouankeu on 9/29/24.
//

import SwiftUI

struct ChatbotPage: View {
    @State private var messages: [Message2] = [
        Message2(role: "system", content: "You are a helpful assistant.") // Initial system prompt
    ]
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false

    private let openAIService = OpenAIService()

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages, id: \.content) { message in
                        if message.role == "user" {
                            HStack {
                                Spacer()
                                Text(message.content)
                                    .padding()
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        } else {
                            HStack {
                                Text(message.content)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()

            HStack {
                TextField("Type your message...", text: $inputText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(minHeight: 45)

                if isLoading {
                    ProgressView()
                        .frame(width: 30, height: 30)
                } else {
                    Button(action: sendMessage) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
    }

    private func sendMessage() {
        guard !inputText.isEmpty else { return }

        // Add user's message
        let userMessage = Message2(role: "user", content: inputText)
        messages.append(userMessage)

        // Clear the input field
        inputText = ""

        // Set loading state
        isLoading = true

        // Send message to OpenAI API
        openAIService.sendMessage(messages: messages) { responseMessage in
            DispatchQueue.main.async {
                isLoading = false
                guard let response = responseMessage else {
                    print("Failed to get response from OpenAI")
                    return
                }

                // Append the assistant's response
                let assistantMessage = Message2(role: "assistant", content: response)
                messages.append(assistantMessage)
            }
        }
    }
}
