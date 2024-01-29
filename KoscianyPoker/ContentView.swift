import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {viewModel.handleRefresh()}) {
                    Text("Nowa gra")
                        .padding(10)
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 55, alignment: .center)
                .background(Color.rozowy)
                .cornerRadius(30)
                
                Button(action: {viewModel.handleInfo()}) {
                    Text("Info")
                        .padding(10)
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 55, alignment: .center)
                .background(Color.rozowy)
                .cornerRadius(30)
            }
            
            if(!viewModel.isInfo){
                if(!viewModel.isFinished){
                    Text("Runda " + String(viewModel.round)).font(.largeTitle)
                    cardDisplay
                    HStack {
                        if(!viewModel.isRolled){
                            reroll
                        }
                        
                        nextRound
                    }
                } else {
                    finishedDisplay
                }
            }
            else{
                infoDisplay
            }
        }
        .padding()
    }
    
    var infoDisplay: some View {
        List{
            Text("Zasady gry").frame(alignment: .center).font(.title)
            Text("⚀ Kazdy z graczy otrzymuje 5 szesciennych kosci.").font(.caption)
            Text("⚁ Gracz widzac kosci swoje oraz rywala moze poprzez klikniecie wybrac kosci, ktore chcialby wylosowac ponownie, a nastepnie przerzucic je przy uzyciu przycisku 'Rzuc ponownie'. Kosci mozna przelosowac tylko raz w kazdej rundzie.").font(.caption)
            Text("⚂ Gracz moze uzyc przycisku 'Koniec rundy' w dowolnym momencie. Spowoduje to zakonczenie rundy oraz sprawdzenie, ktory z graczy ma lepsze kosci.").font(.caption)
            Text("⚃ Gre wygrywa gracz, ktory jako pierwszy zdobedzie 3 punkty (3 wygrane rundy).").font(.caption)
            Text("⚄ W przypadku remisu zaden z graczy nie otrzymuje punktu.").font(.caption)
            Text("Stopnie waznosci ukladow kosci od najnizszego:").font(.headline)
            Text("Nic – pięć nie tworzących żadnego układu oczek.").font(.caption)
            Text("Para – dwie kości o tej samej liczbie oczek.").font(.caption)
            Text("Dwie Pary – dwie pary kości, o tej samej liczbie oczek.").font(.caption)
            Text("Trójka – trzy kości o tej samej liczbie oczek.").font(.caption)
            Text("Mały Strit – kości pokazujące wartości od 1 do 5, po kolei.").font(.caption)
            Text("Duży Strit – kości pokazujące wartości od 2 do 6, po kolei.").font(.caption)
            Text("Full – jedna para i trójka.").font(.caption)
            Text("Kareta – cztery kości o tej samej liczbie oczek.").font(.caption)
            Text("Poker – pięć kości o tej samej liczbie oczek.").font(.caption)
        }
    }
    
    var cardDisplay: some View {
        HStack {
            VStack{
                Text("Gracz").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Punkty: " + String(viewModel.playerPoints)).font(.title3)
                ForEach(0..<viewModel.cardsPlayer.count, id: \.self){ index in
                    CardView(viewModel.cardsPlayer[index])
                        .rotationEffect(.degrees(viewModel.isRolled ? 360 : 0))
                        .animation(.easeInOut(duration: 1), value: viewModel.isRolled)
                        .rotationEffect(.degrees(viewModel.isNextRound ? 360 : 0))
                        .animation(.easeInOut(duration: 1), value: viewModel.isNextRound)
                        .onTapGesture {
                            viewModel.choose(card: viewModel.cardsPlayer[index])
                        }
                }
            }
            Spacer()
            VStack{
                Text("Oponent").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Punkty: " + String(viewModel.opponentPoints)).font(.title3)
                ForEach(0..<viewModel.cardsOpponent.count, id: \.self){ index in
                    CardView(viewModel.cardsOpponent[index])
                        .rotationEffect(.degrees(viewModel.isNextRound ? 360 : 0))
                        .animation(.easeInOut(duration: 1), value: viewModel.isNextRound)
                }
            }
        }
    }
    
    var finishedDisplay: some View {
        if (viewModel.playerPoints>viewModel.opponentPoints){
            Text("Wygrana! ☺︎")
                .font(.title)
        }
        else{
            Text("Przegrana ☹︎")
                .font(.title)
        }
    }
    
    var reroll: some View {
        Button(action: {viewModel.handleReroll()}) {
            Text("Rzuć ponownie").padding(10)
        }
        .font(.system(size: 22))
        .foregroundColor(.pink)
        .frame(minWidth: 45, minHeight: 55)
        .border(.pink, width: 2)
        .cornerRadius(5)
    }
    
    var nextRound: some View {
        Button(action: {viewModel.handleNextRound()}){
            Text("Koniec rundy").padding(10)
        }
        .font(.system(size: 22))
        .foregroundColor(.pink)
        .frame(minWidth: 45, minHeight: 55)
        .border(.pink, width: 2)
        .cornerRadius(5)
    }
}
