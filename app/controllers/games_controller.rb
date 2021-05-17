require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @score = 0
    @word = params[:suggestion].downcase
    @check = api_check(@word)
    @included = included(@word, @letters)
  end

  def api_check(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end

  def included(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end
end
