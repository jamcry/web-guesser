require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

def check_guess(guess)
  return if guess.nil?
  guess = guess.to_i
  if guess > SECRET_NUMBER + 5
    ["Way too high!", "red",]
  elsif guess > SECRET_NUMBER
    ["Too high!", "orange"]
  elsif guess < SECRET_NUMBER
    ["Too low!", "orange"]
  elsif guess < SECRET_NUMBER - 5
    ["Way too low", "red"]
  elsif guess == SECRET_NUMBER
    ["You got it right!\nThe SECRET NUMBER is #{SECRET_NUMBER}", "green"]
  end
end

get '/' do
  # get the user guess
  user_guess = params['guess']
  message, button_color = check_guess(user_guess)
  # pass local variables 'SECRET_NUMBER' and 'message'
  # to ERB template named 'index'
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :button_color => button_color}
end