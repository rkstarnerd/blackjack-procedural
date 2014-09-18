require'pry'

def calculate_total(cards)

  array = cards.map {|e| e[1]}
  
  total = 0

  array.each do |value|
    if value == 'Ace'
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end
  
  array.select { |e| e[1] == 'Ace'}.count.times do
    total -= 10 if total > 21
  end

  return total
end
puts "Let's play Blackjack!"
puts "Enter your name: "
name = gets.chomp.capitalize

suits = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

deck = suits.product(cards)
deck.shuffle!

player_cards = []
dealer_cards = []

player_cards << deck.pop
player_cards << deck.pop
player_total = calculate_total(player_cards)

puts "#{name}, you were dealt #{player_cards}"
puts "You have a total of #{player_total}"

dealer_cards << deck.pop
puts "The dealer is showing #{dealer_cards}"
dealer_cards << deck.pop
dealer_total = calculate_total(dealer_cards)

#binding.pry

puts "Would you like to Hit (Press 1) or Stay (Press 2)"
hit_stay = gets.chomp

while hit_stay == '1'
  player_cards << deck.pop
  player_total = calculate_total(player_cards)
  puts "You now have #{player_cards}, #{player_total}"
  puts "Would you like to Hit (Press 1) or Stay (Press 2)"
  hit_stay = gets.chomp
end

while hit_stay == '2' && dealer_total < 17
    dealer_cards << deck.pop
    dealer_total = calculate_total(dealer_cards)
    puts "The dealer drew a card."
end

if hit_stay == '2'
  puts "Your total is #{player_total} and the dealer has #{dealer_total}"
  if player_total == 21
   puts "Blackjack!  You won!"
  elsif player_total > 21
    puts "Busted! You lost.."
  elsif dealer_total == 21
    puts "Dealer has Blackjack! You lost.."
  elsif dealer_total > 21
    puts "Dealer is Busted!  You won!"
  elsif (player_total <= 21) && (player_total > dealer_total)
    puts "You won!"
  else (player_total <= 21) && (player_total < dealer_total)
    puts "You lost.."
  end
end
