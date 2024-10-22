
import SwiftUI

struct GenerateIDScreen: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var user: User
    
    var body: some View {
        VStack {
            Text("We have generate a unique ID for you")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.vertical)
            
            Text(user.ID)
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
                EnterPINScreen(isLoggedIn: $isLoggedIn, user: $user)
            }, label: {
                StandardBtnLbl(title: "Next", background: .blue)
            })
            .padding(.vertical)
            
            Spacer()
        }
        .navigationTitle("Unique ID")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .onAppear {
            user.ID = generateID()
            user.email = "\(user.uniqueName.lowercased())@gmail.com"
        }
    }
    
    //MARK: - Function
    
    private func generateID() -> String {
        let randStr = randomString(length: 7)
        let randInt = Int.random(in: 1..<10000000)
        return "ID_\(randInt)_\(randStr)"
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" //length = 62
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

#Preview {
    GenerateIDScreen(isLoggedIn: .constant(false), user: .constant(User.initUser))
}
