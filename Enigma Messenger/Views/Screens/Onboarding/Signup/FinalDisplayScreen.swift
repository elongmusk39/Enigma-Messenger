
import SwiftUI

struct FinalDisplayScreen: View {
    
    @Binding var user: User
    @State var showLoading = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 24) {
                
                infoLabel(context: "Name", user: user)
                infoLabel(context: "ID", user: user)
                infoLabel(context: "PIN", user: user)
                
                Spacer()
                
                Button {
                    Task {
                        showLoading = true
                        try? await Task.sleep(nanoseconds: 0_100_000_000)
                        
                        showLoading = false
                    }
                } label: {
                    StandardBtnLbl(title: "Let's go", background: .blue)
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
    FinalDisplayScreen(user: .constant(User.initUser))
}

//-------------------------------------------

struct infoLabel: View {
    
    var context: String
    var user: User
    
    var body: some View {
        Text("\(context): \(user.PIN)")
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
    }
}
