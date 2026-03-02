//
//  MainMenu.swift
//  Order in the Library
//
//  Created by Aiden Baker on 1/29/26.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack() {
                    VStack(spacing: 15) {
                        Image(systemName: "books.vertical.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.blue)
                            .shadow(radius: 2)
                        
                        Text("Order in the Library")
                            .font(.system(size: 32, weight: .heavy, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 40)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundStyle(.orange)
                                Text("How to Play")
                                    .font(.headline)
                            }
                            Text("Use the Dewey Decimal System (DDC) to sort the books correctly. Arrange them by number, then by author letters!")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        // The Reward
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("The Goal")
                                    .font(.headline)
                            }
                            Text("Beat all 3 levels to prove your sorting skills.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                        
                        // Certificate Preview
                        HStack {
                            Image(systemName: "certificate.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.red)
                            
                            VStack(alignment: .leading) {
                                Text("Final Prize")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                Text("Official Librarian Certificate")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    Spacer()
                    
                    NavigationLink(destination: PickMenuView()) {
                        HStack {
                            Text("Start Sorting")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal, 40)
                }
            }
        }
    }
}

#Preview {
    MainMenu()
}
