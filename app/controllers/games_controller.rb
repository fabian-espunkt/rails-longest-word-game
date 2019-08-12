require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    @score = params["word"].upcase
    @letters = params["letters"].split()
    url = "https://wagon-dictionary.herokuapp.com/#{@score}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    # raise
    if @score.split("").all? { |e| @letters.include?(e) }
      if word['found'] == true
      @result = "Congratulations! #{@score.capitalize} is a valid English word."
      elsif word['found'] == false
      @result = "Sorry, but #{@score.capitalize} does not seem to be a valid English word."
      end
    else
      @result = "Sorry but #{@score} can't be built out of #{@letters.join(", ")}"
    end
  end
end
