require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters_array = Array.new(10) { [*'A'..'Z'].sample }
    # params = ActionController::Parameters.new(letters: @letters_array)
  end

  def score
    @grid = params[:letters_array].split
    @letters = params[:word].upcase.split('')
    @url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @english_word = JSON.parse(open(@url).read)
    # @english_word.each do |item|
    #   params[:word] = item ? @is_english += 1 : @is_english += 0
    # end
    # raise

    if (@letters - @grid).any?
      my_result = "Sorry but #{params[:word].upcase} can't be built out of
      #{@grid.join(', ')}"
    elsif @english_word["found"] == false
      my_result = "Sorry but #{params[:word].upcase} doesn't seem to
      be a valid English word.."
    else
      my_result = "Congratulations! #{params[:word].upcase} is
      a valid English word."
    end
    render plain: my_result
  end
end
