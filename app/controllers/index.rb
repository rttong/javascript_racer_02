get '/' do
  erb :index
end

post '/setup' do
  player1 = Player.find_or_create_by_name(params[:player1])
  player2 = Player.find_or_create_by_name(params[:player2])
  current_game = Game.create(url: SecureRandom.hex(5))
  player1.games << current_game
  player2.games << current_game
  redirect "/gameplay/#{current_game.id}"
end

get '/gameplay/:game_id' do |game_id|
  @game_id = game_id
  erb :game
end

post '/gameplay' do
  current_game = Game.find(params[:current_game])
  current_game.update_attributes(time_elapsed: params[:time], finished: true)

  if params[:winner] == 'player1'
    current_round = Round.find_all_by_game_id(params[:current_game]).first
    current_round.update_attributes(winner: true)
  elsif params[:winner] == 'player2'
    current_round = Round.find_all_by_game_id(params[:current_game]).last
    current_round.update_attributes(winner: true)
  end

  redirect "/stats/#{current_game.url}"
end

get '/stats/:game' do |game|
  @url = game
  displayed_game = Game.find_by_url(game)
  @time_elapsed = displayed_game.time_elapsed
  displayed_round = Round.find_all_by_game_id(displayed_game.id)
  
  @winner = nil
  displayed_round.each do |round|
    if round.winner == true
      @winner = Player.find(round.player_id)
      @winner = @winner.name
    end
  end
  
  erb :stats  
end
