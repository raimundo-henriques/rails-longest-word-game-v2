require 'open-uri'
class GamesController < ApplicationController
  def new
    @vowels = Array.new(5) { ['A','E','I','O','U'].sample }
    @all_letters = Array.new(5) { ('A'..'Z').to_a.sample }
    @letters = (@vowels << @all_letters).flatten!.shuffle!
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase
    @is_included = included?(@word, @letters)
    @is_english = english?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    json['found']
  end
end
