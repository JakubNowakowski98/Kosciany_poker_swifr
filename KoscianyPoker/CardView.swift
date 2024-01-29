import SwiftUI

struct CardView: View {
    var cardModel: CardModel
    
    init(_ card: CardModel){
        self.cardModel = card
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.czerwony)
                .frame(width: 90, height: 90)
            
            Circle()
                .fill(.white.opacity(0.17))
                .frame(width: 81, height: 81)
                .overlay{
                    if (!cardModel.isTapped) {
                        Text(String(cardModel.number))
                    }
                    else {
                        Text("?")
                    }
                }
        }
            
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(CardModel(number: 0, isEditable: true, isTapped: false))
    }
}

extension Color {
    static let czerwony = Color(red: 240/255, green: 118/255, blue: 139/255)
    static let rozowy = Color(red: 255/255, green: 102/255, blue: 153/255)
}

#Preview {
    CardView(CardModel(number: 0, isEditable: true, isTapped: false))
}
