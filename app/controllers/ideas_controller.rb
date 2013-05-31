class IdeasController < ApplicationController
  def index
    @ideas = params[:type].present? ? idea_type.all : Idea.all
  end

  def new
    @idea = idea_type.new
  end

  def create
    @idea = idea_type.create params[params[:type].underscore.to_sym]
    
    if @idea.save
      flash[:success]="#{@idea.class.to_s.titleize} #{@idea.name} was successfully created."
      redirect_to root_url
    else
      flash.now[:error] = @idea.errors.full_messages.to_sentence
      render :action=>"new" 
    end
  end

  def show
    @idea = idea_type.find(params[:id])
  end

  def edit
    @idea = idea_type.find(params[:id])
  end

  def update
    @idea = idea_type.find(params[:id])
    @idea.update_attributes(params[params[:type].underscore.to_sym])
    if @idea.save
      flash[:success]="#{@idea.class.to_s.titleize} #{@idea.name} was successfully created."
      redirect_to root_url
    else
      flash.now[:error] = @idea.errors.full_messages.to_sentence
      render :action=>"edit" 
    end
  end

  private

  def idea_type
    params[:type].constantize
  end

end
