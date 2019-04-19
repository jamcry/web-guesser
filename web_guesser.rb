require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

def check_guess(guess)
  return if guess.nil?
  guess = guess.to_i
  if guess > SECRET_NUMBER + 5
    "Way too high!"
  elsif guess > SECRET_NUMBER
    "Too high!"
  elsif guess < SECRET_NUMBER
    "Too low! #{guess}"
  elsif guess < SECRET_NUMBER - 5
    "Way too low"
  elsif guess == SECRET_NUMBER
    "You got it right!\nThe SECRET NUMBER is #{SECRET_NUMBER}"
  end
end

get '/' do
  # get the user guess
  user_guess = params['guess']
  message = check_guess(user_guess)
  # pass local variables 'SECRET_NUMBER' and 'message'
  # to ERB template named 'index'
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end