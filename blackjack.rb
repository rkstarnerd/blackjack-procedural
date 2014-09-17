puts "\t\t*** Let's Play Blackjack!***\n What's your name?"
$player = gets.chomp.capitalize

def play

  $deck = {
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

  player_card_1 = $deck.keys.shuffle.shift
  player_card_2 = $deck.keys.shuffle.shift
  puts "Welcome, #{$player}.\n #{player_card_1}, #{player_card_2}."
  if player_card_1.include? 'Ace' 
    puts "Your hand has a value of #{11 + deck[player_card_2]} or #{1 + deck[player_card_2]}"
  elsif player_card_2.include? 'Ace'
    puts "Your hand has a value of #{11 + deck[player_card_1]} or #{1+ deck[player_card_1]}"
  else
  $player_cards_value = $deck[player_card_1] + $deck[player_card_2]
  puts "Your hand has a value of #{$player_cards_value}"
  end

  $deck.delete(player_card_1)
  $deck.delete(player_card_2)

  dealer_card_1 = $deck.keys.shuffle.shift
  dealer_card_2 = $deck.keys.shuffle.shift
  $dealer_cards_value = $deck[dealer_card_1] + $deck[dealer_card_2]
  $deck.delete(dealer_card_1)
  $deck.delete(dealer_card_2)

  puts "The dealer is showing #{dealer_card_2}"

blackjack?

end

def blackjack?
  if $player_cards_value == 21
    puts "You have Blackjack!\n You won!"
    play_again
  elsif $dealer_cards_value == 21
    puts "The dealer has Blackjack!\n You lost.."
    play_again
  elsif $player_cards_value >= 22
    puts "Busted!\n You lost.."
    play_again
  elsif $dealer_cards_value >= 22
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
    puts "You have #{$player_cards_value}."
    if $dealer_cards_value < 17
      dealer_hit
    elsif ($player_cards_value > $dealer_cards_value) && ($player_cards_value <= 21)
      puts "The dealer has #{$dealer_cards_value}.\n You won!"
      play_again
    else
      puts "The dealer has #{$dealer_cards_value}\n Sorry.. House wins.."
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
  until $dealer_cards_value >= 17
    dealer_new_card = $deck.keys.shuffle.shift
    puts "The dealer has added #{dealer_new_card}"
    $dealer_cards_value = $deck[dealer_new_card] + $dealer_cards_value
    $deck.delete(dealer_new_card)
  end
  puts "The dealer stays at #{$dealer_cards_value}"
  blackjack?
end

def hit
  new_card = $deck.keys.shuffle.shift
  puts "You have added #{new_card}"
  $player_cards_value = $deck[new_card] + $player_cards_value
  puts "You now have #{$player_cards_value}"
  $deck.delete(new_card)
  if $dealer_cards_value < 17
    dealer_hit
  else 
    puts "The dealer stays at #{$dealer_cards_value}"
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