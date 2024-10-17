
import SwiftUI

struct FinalDisplayScreen: View {
    
    @Binding var showAuthScr: Bool
    @State var showLoading = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 24) {
                Text("Name: Long Nguyen")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(Color(.systemGray4))
                            .shadow(color: .black.opacity(0.4), radius: 2)
                    })
                
                Text("AI23vC$#%*fhGesFdJKfWh$!@*kd")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(Color(.systemGray4))
                            .shadow(color: .black.opacity(0.4), radius: 2)
                    })
                
                
                Text("PIN: 123456")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(Color(.systemGray4))
                            .shadow(color: .black.opacity(0.4), radius: 2)
                    })
                
                Spacer()
                
                Button {
                    Task {
                        showLoading = true
                        try? await Task.sleep(nanoseconds: 0_400_000_000)
                        showLoading = false
                        showAuthScr.toggle()
                    }
                } label: {
                    StandardBtnLbl(title: "Let's go")
                }
                .padding(.vertical)
            }
            .padding()
            
            if showLoading {
                LoadingView()
            }
        }
        .navigationTitle("Your Information")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FinalDisplayScreen(showAuthScr: .constant(false))
}
