require 'pry'

def calculate_total(cards)
  cards.inject { |sum, n| sum + n }
end

def blackjack(total1, total2)
  if total1 == 21
    puts "\n\tBlackjack! You won!"
    puts "\n\tWould you like to play again? (Y/N)"
  elsif total1 > 21
    puts "\n\tBusted! You lost.."
    puts "Would you like to play again? (Y/N)"
  elsif total2 == 21
    puts "\n\tDealer has Blackjack!  You lost.."
  elsif total2 > 21
    puts "\n\tDealer Busted!  You won!"
  else
    puts "hmmm.."
  end
end

def hit_stay(action, deck, shuffled_cards, player_cards, dealer_cards, blackjack, calculate_total)
  if action == '1'
    player_card_new = shuffled_cards.shift
    player_cards << deck[player_card_new]
    player_total = calculate_total(player_cards)
    puts "You drew #{player_card_new}"
    if dealer_total < 17
      dealer_new_card = shuffled_cards.shift
      dealer_cards <<  deck[dealer_new_card]
      dealer_total = calculate_total(dealer_cards)
      puts "Dealer draws #{dealer_new_card}"
    else
      puts "Dealer stays at #{dealer_total}"
    end 
  blackjack(player_total, dealer_total)
  hit_stay
  elsif (action == '2') && (player_total > dealer_total) 
    puts "\n\tThe dealer has #{dealer_total}\n\t You won!"
    play_again
  elsif (action == '2') && (player_total < dealer_total)
    puts "\n\tThe dealer has #{dealer_total}\n\t WOMP! Womp. womp... You lost."
    play_again
  else
    puts "\n\tPlease enter a valid response."
    action = gets.chomp
  end
end

def play_again
  puts "\n\tWould you like to play again? (Y/N)"
  response = gets.chomp.upcase
  if response == 'Y'
    puts "We'll play again.."
  elsif response == 'N'
    puts "\n\tThanks for playing!"
  else
    puts "\n\tI'll take that as a no... Thanks for playing!"
  end
end


deck = {
        'Ace of Spades' => 11, 'King of Spades' => 10, 'Queen of Spades' => 10, 
        'Jack of Spades' => 10, '10 of Spades' => 10, '9 of Spades' => 9, 
        '8 of Spades' => 8, '7 of Spades' => 7, '6 of Spades' => 6, 
        '5 of Spades' => 5, '4 of Spades' => 4, '3 of Spades' => 3, 
        '2 of Spades' => 2,'Ace of Hearts' => 11, 'King of Hearts' => 10, 
        'Queen of Hearts' => 10, 'Jack of Hearts' => 10, '10 of Hearts' => 10, 
        '9 of Hearts' => 9, '8 of Hearts' => 8, '7 of Hearts' => 7, 
        '6 of Hearts' => 6, '5 of Hearts' => 5, '4 of Hearts' => 4, 
        '3 of Hearts' => 3, '2 of Hearts' => 2,'Ace of Diamonds' => 11, 
        'King of Diamonds' => 10, 'Queen of Diamonds' => 10, 
        'Jack of Diamonds' => 10, '10 of Diamonds' => 10, '9 of Diamonds' => 9, 
        '8 of Diamonds' => 8, '7 of Diamonds' => 7, '6 of Diamonds' => 6, 
        '5 of Diamonds' => 5, '4 of Diamonds' => 4, '3 of Diamonds' => 3, 
        '2 of Diamonds' => 2, 'Ace of Clubs' => 11, 'King of Clubs' => 10, 
        'Queen of Clubs' => 10, 'Jack of Clubs' => 10, '10 of Clubs' => 10, 
        '9 of Clubs' => 9, '8 of Clubs' => 8, '7 of Clubs' => 7, 
        '6 of Clubs' => 6, '5 of Clubs' => 5, '4 of Clubs' => 4, 
        '3 of Clubs' => 3, '2 of Clubs' => 2,
       }

puts "\n\tLet's play Blackjack!\n\t Player, enter your name:"
player = gets.chomp.capitalize

shuffled_cards = deck.keys.shuffle
player_cards = []
player_card_1 = shuffled_cards.shift
player_cards << player_card_1
player_card_2 = shuffled_cards.shift
player_cards << player_card_2
player_cards.map! { |e| deck[e]}
player_total = calculate_total(player_cards)

puts "\n\t#{player}, you were dealt: #{player_card_1}, #{player_card_2}"
puts "\tYour total is #{player_total}"

dealer_cards = []
dealer_card_1 = shuffled_cards.shift
dealer_cards << dealer_card_1
dealer_card_2 = shuffled_cards.shift
dealer_cards << dealer_card_2
dealer_cards.map! { |e| deck[e]}
dealer_total = calculate_total(dealer_cards)

puts "\n\tThe dealer is showing #{dealer_card_2}"

blackjack(player_total, dealer_total)

puts "Would you like to Hit (Press 1) or Stay (Press 2)"
action = gets.chomp
hit_stay(action, deck, shuffled_cards, player_cards, dealer_cards, blackjack)
blackjack(player_total, dealer_total)
