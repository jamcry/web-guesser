require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@guess_remaining = 5

def check_guess(guess)
  @@guess_remaining -= 1
  return if guess.nil?
  guess = guess.to_i
  if guess > @@secret_number + 5
    ["Way too high!", "red", false]
  elsif guess > @@secret_number
    ["Too high!", "orange", false]
  elsif guess < @@secret_number
    ["Too low!", "orange", false]
  elsif guess < @@secret_number - 5
    ["Way too low", "red", false]
  elsif guess == @@secret_number
    ["You got it right!\nThe SECRET NUMBER is #{@@secret_number}", "green", true]
  end
end

def check_guess_remaining(win)
  if @@guess_remaining == 0
    @@secret_number = rand(101)
    @@guess_remaining = 5
    return "YOU LOST! I picked another number for you."
  elsif win
    @@secret_number = rand(101)
    @@guess_remaining = 5
    return "<b>YOU WIN! I picked another number for you.</b>"
  else
    return "Guesses Remaining: #{@@guess_remaining}"
  end
end

get '/' do
  # get the user guess
  user_guess = params['guess']
  message, button_color, win = check_guess(user_guess)
  guess_message = check_guess_remaining(win)
  secret_message = (params['cheat'] == "true" ? "The SECRET NUMBER is #{@@secret_number}." : "")
  # pass local variables to ERB template 'index'
  erb :index, :locals => {:number => @@secret_number, :message => message,
                          :button_color => button_color, :secret_message => secret_message,
                          :guess_message => guess_message}
end