
import SwiftUI

struct GenerateIDScreen: View {
    
    @Binding var showAuthScr: Bool
    
    var body: some View {
        VStack {
            Text("We have generate a unique ID for you")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.vertical)
            
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
            
            
            Text("Store this ID in a safe place. You will use it to log in later on")
                .font(.footnote)
                .foregroundStyle(.gray)
                        
            NavigationLink(destination: {
                EnterPINScreen(showAuthScr: $showAuthScr)
            }, label: {
                StandardBtnLbl(title: "Next", background: .blue)
            })
            .padding(.vertical)
            
            Spacer()
        }
        .navigationTitle("Unique ID")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

#Preview {
    GenerateIDScreen(showAuthScr: .constant(false))
}
