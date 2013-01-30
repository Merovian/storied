class CharactersController < ApplicationController
  def new
    @character = Character.new
  end

  def create
    @character = Character.create params[:character]
    
    respond_to do |format|
      if @character.save
        format.html { redirect_to(root_url, :notice => "Character #{@character.name} was successfully created.") }
        format.xml  { render :xml => @character, :status => :created, :location => root_url }
      else
        format.html { render :action=>"new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    @character.update_attributes(params[:character])
    respond_to do |format|
      if @character.save
        format.html { redirect_to(root_url, :notice=> "Character #{@character.name} was successfully updated.") }
        format.xml  { render :xml => @character, :status=>:updated, :location => root_url }
      else
        format.html { render :action=>"edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

end
