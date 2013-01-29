class IdeasController < ApplicationController
  def index
    @idea_types = %w(character)
    @my_things = Hash.new
    @my_things['characters'] = Character.all
  end
end
