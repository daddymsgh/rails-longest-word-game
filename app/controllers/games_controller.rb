require 'open-uri'
class GamesController < ApplicationController
  def new
    alphabet = ("a".."z").to_a
    @random_letters = alphabet.sample(10)
  end

  def score
    score = 0
    random_letters = params[:letters].split(' ')
    word = params[:word].downcase
    invalid_letters = word.chars.any? { |char| !random_letters.include?(char) }
    @word = params[:word]
    url = "https://dictionary.lewagon.com/#{@word}"
    # This returns a JSON
    response = URI.open(url).read
    # This turns the JSON into a Ruby object
    data = JSON.parse(response)
    english_word = data["found"]
    if invalid_letters
      @message = "You lose #{word} is not included in the letters choice"
    elsif english_word == false
      @message = "You lose #{word} is not an english word"
    else
     @message = "You win ! #{word} is #{word.size}letter and #{word.size} points !"

    end
  end
  end
