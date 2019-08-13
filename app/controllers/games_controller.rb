require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = ('A'..'Z').to_a.sample(10)
    # OU
    # array = ('A'..'Z').to_a
    # @letters = []
    # 10.times { @letters << array[rand(array.size)] }
    console
  end

  def score
    console
    #JE METS lES LETTRES DU JOUEUR DANS UN ARRAY:
    @word = params[:word]
    @letter_post = params[:letters]
    @english = english?
    @include = word_to_grid?(@word, @letter_post)
  end

  def english?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    json = JSON.parse(open(url).read)
    json["found"]
  end

 def word_to_grid?(word, grid)
    word.upcase.chars.all? do |letter|
      word.upcase.count(letter) <= grid.split('').count(letter)
    end
  end






    # SI LES LETTRES N EXISTENT PAS TOUTE DANS LA GRILLE
    #   "Sorry but word can't be built out of @letters"
    # SI LES LETTRES DU MOT EXISTENT DANS LA GRILLE, MAIS LE MOT N EST PAS UN ENGLISH WORD SELON L API
    #   "Sorry but word does not seem to be a valid English word..."
    # SI LES LETTRES DU MOT EXISTENT DANS LA GRILLE, ET LE WORD EST UN ENGLISH WORD SELON L API
    #   "Congratulations! word is a valid English word!"
  end
end
