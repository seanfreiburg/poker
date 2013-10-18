require 'net/http'
require_relative 'poker_bot'

deal_key =  '/sandbox/players/deal-phase-key'
flop_key = '/sandbox/players/flop-phase-key'
turn_key =   '/sandbox/players/turn-phase-key'
river_key =   '/sandbox/players/river-phase-key'

real_key = '/api/players/a3affc74-9f1f-4cee-a9cc-cce0204ce0cb'


main(real_key)


#data = {"name"=>"Bill16", "your_turn"=>true, "initial_stack"=>250, "stack"=>250, "current_bet"=>nil, "call_amount"=>10, "hand"=>["TS", "TS"], "betting_phase"=>"deal", "players_at_table"=>[{"player_name"=>"Bill16", "initial_stack"=>250, "current_bet"=>0, "stack"=>250, "folded"=>false, "actions"=>[]}, {"player_name"=>"Bill17", "initial_stack"=>250, "current_bet"=>5, "stack"=>245, "folded"=>false, "actions"=>[{"action"=>"ante", "amount"=>5}]}, {"player_name"=>"Bill18", "initial_stack"=>250, "current_bet"=>10, "stack"=>240, "folded"=>false, "actions"=>[{"action"=>"ante", "amount"=>10}]}], "total_players_remaining"=>3, "table_id"=>427, "round_id"=>447, "round_history"=>[{"round_id"=>447, "table_id"=>427, "stack_change"=>nil}], "lost_at"=>nil, "community_cards"=>[]}

#puts get_river_action(data)