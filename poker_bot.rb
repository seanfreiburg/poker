require 'net/http'
require 'json'
require 'open-uri'



CODE_EM_URI = 'nolimitcodeem.com'

def logic(turn_data)
  card1, card2 = get_hand(turn_data)
  card1_num = card1.split('')[0]
  card2_num = card2.split('')[0]
  if turn_data['current_bet'].to_f > turn_data['stack'].to_i * 0.5
    return 'fold', nil
  elsif card1_num == card2_num
    if card1_num == '8'
      return 'call', nil
    elsif card1_num == '9'
      return 'call', nil
    elsif card1_num == 'T'
      return 'call', nil
    elsif card1_num == 'J'
      return 'call', nil
    elsif card1_num == 'Q'
      return 'raise', (turn_data['stack'].to_i * 0.3).to_i.to_s
    elsif card1_num == 'K'
      return 'raise', (turn_data['stack'].to_i * 0.4).to_i.to_s
    elsif card1_num == 'A'
      return 'raise', (turn_data['stack'].to_i * 0.5).to_i.to_s
    else
      if card1_num == 'A' ||card2_num == 'A'
        return 'call', nil
      elsif card1_num == 'K' ||card2_num == 'K'
        return 'call', nil
      else
        return 'fold', nil
      end
    end
  else

    if card1_num == 'A' ||card2_num == 'A'
      return 'call', nil
    elsif card1_num == 'K' ||card2_num == 'K'
      return 'call', nil
    else
      return 'fold', nil
    end
  end
end


def get_hand(turn_data)
  card1, card2 =  turn_data['hand']

end

def get_deal_action(turn_data)

 return logic(turn_data)

end

def get_flop_action(turn_data)
  community_cards = turn_data['community_cards']

  return logic(turn_data)
end

def get_turn_action(turn_data)
  community_cards = turn_data['community_cards']
  return logic(turn_data)
end

def get_river_action(turn_data)
  community_cards = turn_data['community_cards']
  return logic(turn_data)
end



def get_action(turn_data)
  if turn_data['community_cards'].empty?
    get_deal_action(turn_data)
  elsif turn_data['community_cards'].length == 3
    get_flop_action(turn_data)
  elsif turn_data['community_cards'].length == 4
    get_turn_action(turn_data)
  else
    get_river_action(turn_data)
  end
end

def get_game_state(key)
  response = Net::HTTP.get(CODE_EM_URI,  key)
  JSON.parse(response)
end

def send_action(key, action,amount)
  uri = URI('http://' + CODE_EM_URI + key + '/action' )

  if amount
    res = Net::HTTP.post_form(uri, action_name: action, amount: amount)
  else
    res = Net::HTTP.post_form(uri, action_name: action)
  end
  puts res.body

end


def main(key)


  loop {
    turn_data = get_game_state(key)
    puts turn_data
    if turn_data['your_turn']
      action,amount = get_action(turn_data)
      send_action(key,action,amount)
    end
    sleep 1
  }
end