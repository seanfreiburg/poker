require 'net/http'
require 'json'
require 'open-uri'

CODE_EM_URI = 'nolimitcodeem.com'


def get_deal_action(turn_data)
  'fold'
end

def get_flop_action(turn_data)
  'fold'
end

def get_turn_action(turn_data)
  'fold'
end

def get_river_action(turn_data)
  'fold'
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
  #puts res.body
end


def main(key)
  loop {
    turn_data = get_game_state(key)
    #puts turn_data
    if turn_data['your_turn']
      action,amount = get_action(turn_data)
      send_action(key,action,amount)
    end
    sleep 1
  }
end