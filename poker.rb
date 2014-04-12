hand_a = { player_1: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 6]], player_2: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 7]], player_3: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 8]] }
hand_b = { player_1: [["q", 10],["q", 11],["q", 12], ["q", 13],["q", 14]], player_2: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 7]], player_3: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 8]] }
hand_c = { player_1: [["s", 1],["q", 2],["q", 10], ["q", 4],["q", 6]], player_2: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 5]], player_3: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 8]] }
hand_d = { player_1: [["s", 1],["q", 1],["q", 1], ["q", 4],["q", 4]], player_2: [["s", 1],["q", 2],["q", 3], ["q", 10],["q", 5]], player_3: [["s", 1],["q", 2],["q", 3], ["q", 4],["q", 8]] }
class Poker
  @@round = 0

  def initialize(hands)
    @@round += 1
    @hands = hands
    @players = hands.length
  end

  def round
    puts "round number #{@@round}"
  end

  def royal_flush(player)
    straight_flush(player) && @hands[player].sort { |s, v| s[1] <=> v[1] }[-1][1] === 14
  end

  def straight_flush(player)
    straight(player) && flush(player)
  end

  def four_of_a_kind(player)
    @hands[player].group_by{ |s, v| v }.map { |s, v| v.length }.include?(4)
  end

  def full_house(player)
    three_of_a_kind(player)  && pair(player)
  end

  def flush(player)
    @hands[player].group_by { |s,v| s }.length === 1
  end

  def straight(player)
    sorted = @hands[player].sort { |s, v| s[1] <=> v[1] }
    straight = true
    4.times do |n|
      if sorted[n][1] - sorted[n+1][1] != -1
        straight = false
      end   
    end
    return straight
  end

  def three_of_a_kind(player)
    @hands[player].group_by{ |s, v| v }.map { |s, v| v.length }.include?(3)
  end

  def two_pair(player)
    @hands[player].group_by{ |s, v| v }.map { |s, v| v.length }.include?(2) && @hands[player].group_by{ |s, v| v }.map { |s, v| v.length }.length === 3
  end

  def pair(player)
    @hands[player].group_by{ |s, v| v }.map { |s, v| v.length }.include?(2)
  end

  def high_card(player)
    @hands[player].sort { |s, v| s[1] <=> v[1] }[-1][1]
  end

  def winner
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(royal_flush(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with a royal flush"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(straight_flush(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with a straight flush"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(four_of_a_kind(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with four of a kind"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(full_house(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with a full house"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(flush(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with a flush"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(straight(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with a straight"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(three_of_a_kind(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with three of a kind"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(two_pair(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with two pair"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(pair(player))
    end
    if winner.include?(true)
      win = Hash[winner.map.with_index.to_a]
      w = win[true]
      return puts "winner is #{@hands.keys[w]} with a pair"
    end
    winner = []
    1.upto(@players) do |n|
      player = ("player_" + n.to_s).to_sym
      winner.push(high_card(player))
    end
    return puts "winner is #{@hands.keys[winner.index(winner.max)]} with a high card"
  end
end

game_one = Poker.new(hand_a)
game_one.winner
# winner is player_3 with a high card

game_two = Poker.new(hand_b)
game_two.winner
# winner is player_1 with a royal flush

game_three = Poker.new(hand_c)
game_three.winner
# winner is player_2 with a straight

game_four = Poker.new(hand_d)
game_four.winner
game_four.round
# winner is player_1 with a full house
# round number 4