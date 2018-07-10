require_relative ('model/bounty')

bounty1 = Bounty.new(
  {'name' => 'Liam Neeson', 'value' => '1000',
  'danger_level' => 'are you kidding?', 'cashed_in' => false}
)

bounty2 = Bounty.new(
  {'name' => 'Tom Cruise', 'value' => '5',
  'danger_level' => 'not very', 'cashed_in' => true}
)

p Bounty.find_by_id(4)
