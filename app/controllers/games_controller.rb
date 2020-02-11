require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('a'...'z').to_a
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    @param = params[:guess]
    @score = 0
    @answer = ''
    url = "https://wagon-dictionary.herokuapp.com/#{@param}"
    dictionnary = open(url).read
    user = JSON.parse(dictionnary)
    @final = user["found"]
    if @final == false
      @answer = "Sorry but #{@param} does not seem to be a valid English word"
    else
      attempt = @param.split(//)
      attempt.each do |letter|
        if params[:letters].split(//).include?(letter) == false
          @answer = 'the given word is not in the grid'
        else
          @answer = 'Good guess'
        end
      end
       @score += attempt.length
    end
  end
end
