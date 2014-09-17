require 'pry'

puts "\t\t*** Let's Play Blackjack!***\n What's your name?"

def play
  player = gets.chomp.capitalize

  deck= {
        'SA' => 11, 'SK' => 10, 'SQ' => 10, 'SJ' => 10, 'S10' => 10, 
        'S9' => 9, 'S8' => 8, 'S7' => 7, 'S6' => 6, 'S5' => 5, 'S4' => 4, 
        'S3' => 3, 'S2' => 2,'HA' => 11, 'HK' => 10, 'HQ' => 10, 'HJ' => 10, 
        'H10' => 10, 'H9' => 9, 'H8' => 8, 'H7' => 7, 'H6' => 6, 'H5' => 5, 
        'H4' => 4, 'H3' => 3, 'H2' => 2, 'DA' => 11, 'DK' => 10, 'DQ' => 10, 
        'DJ' => 10, 'D10' => 10, 'D9' => 9, 'D8' => 8, 'D7' => 7, 'D6' => 6, 
        'D5' => 5, 'D4' => 4, 'D3' => 3, 'D2' => 2, 'CA' => 11, 'CK' => 10, 
        'CQ' => 10, 'CJ' => 10, 'C10' => 10, 'C9' => 9, 'C8' => 8, 'C7' => 7, 
        'C6' => 6, 'C5' => 5, 'C4' => 4, 'C3' => 3, 'C2' => 2
       }.shuffle

  player_cards = []


  player_card_1 = player_cards << deck.keys.shift
  player_card_2 = player_cards << deck.keys.shift
  player_cards_value = deck[player_card_1] + deck[player_card_2]
  deck.delete(player_card_1)
  deck.delete(player_card_2)

  puts "Welcome, #{player}.\n #{player_card_1}, #{player_card_2}."
  puts "Your hand has a value of #{player_cards_value}"

  dealer_card_1 = deck.keys.shuffle.shift
  dealer_card_2 = deck.keys.shuffle.shift
  dealer_cards_value = deck[dealer_card_1] + deck[dealer_card_2]
  deck.delete(dealer_card_1)
  deck.delete(dealer_card_2)

  puts "The dealer is showing #{dealer_card_2}"
  binding.pry

blackjack?

end

def blackjack?
  if player_cards_value == 21
    puts "You have Blackjack!\n You won!"
    play_again
  elsif dealer_cards_value == 21
    puts "The dealer has Blackjack!\n You lost.."
    play_again
  elsif player_cards_value >= 22
    puts "Busted!\n You lost.."
    play_again
  elsif dealer_cards_value >= 22
    puts "The dealer is Busted!\n You won!"
    play_again
  else
    hit_stay
   end
end

def hit_stay
  puts "Would you like to Hit (Press 1) or Stay (Press 2)?"
  action = gets.chomp
  if action == '2'
    puts "You have #{player_cards_value}."
    if dealer_cards_value < 17
      dealer_hit
    elsif (player_cards_value > dealer_cards_value) && (player_cards_value <= 21)
      puts "The dealer has #{dealer_cards_value}.\n You won!"
      play_again
    else
      puts "The dealer has #{dealer_cards_value}\n Sorry.. House wins.."
      play_again
    end
  elsif action =='1'
    hit
  else
    puts "Please choose Hit (Press 1) or Stay (Press 2)."
    action = gets.chomp
  end
end

def dealer_hit
  until dealer_cards_value >= 17
    dealer_new_card = deck.keys.shuffle.shift
    puts "The dealer has added #{dealer_new_card}"
    dealer_cards_value = deck[dealer_new_card] + dealer_cards_value
    deck.delete(dealer_new_card)
  end
  puts "The dealer stays at #{dealer_cards_value}"
  blackjack?
end

def hit
  new_card = deck.keys.shuffle.shift
  puts "You have added #{new_card}"
  player_cards_value = deck[new_card] + player_cards_value
  puts "You now have #{player_cards_value}"
  deck.delete(new_card)
  if dealer_cards_value < 17
    dealer_hit
  else 
    puts "The dealer stays at #{dealer_cards_value}"
  end
  blackjack?
end

def play_again
  puts "Would you like to play again? (Y/N)"
  answer = gets.chomp.upcase
  if answer == 'Y'
    play
  elsif answer == 'N'
    puts "Thanks for playing!"
  else
    puts "Please enter Y or N"
    answer = gets.chomp.upcase
  end
end

play