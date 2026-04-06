//
//  CertificateView.swift
//  Order in the Library
//
//  Created by Aiden Baker on 3/30/26.
//

import SwiftUI

struct CertificateView: View {
    @Environment(\.dismiss) private var dismiss // Lets us close this screen from code

    var body: some View {
        NavigationStack { // Provides navigation UI like a title bar
            VStack(spacing: 20) {
                Image(systemName: "rosette")
                    .font(.system(size: 60))
                    .foregroundStyle(.yellow)

                Text("You Did It!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)

                Text("You've mastered all 3 levels and earned your Official Librarian Certificate!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // shows the save button to allow the user to download a copy of their cert, this allows them to keep it forever.
                ShareLink(item: Bundle.main.url(forResource: "cert", withExtension: "pdf")!, preview: SharePreview("Librarian Certificate", image: Image(systemName: "doc.fill"))) {
                    Label("Save My Certificate", systemImage: "arrow.down.circle.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 40)
            }
            .padding()
            .navigationTitle("Your Certificate")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // Add a Done button to close the sheet
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() } // Calls the environment dismiss action
                }
            }
        }
    }
}

#Preview {
    CertificateView()
}
