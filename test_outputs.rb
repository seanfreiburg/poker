require 'net/http'
require_relative 'poker_bot'

deal_key =  '/sandbox/players/deal-phase-key'
flop_key = '/sandbox/players/flop-phase-key'
turn_key =   '/sandbox/players/turn-phase-key'
river_key =   '/sandbox/players/river-phase-key'

real_key = nil

main(deal_key)

