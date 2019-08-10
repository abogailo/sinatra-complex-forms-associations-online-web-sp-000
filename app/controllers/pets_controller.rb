class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if params[:owner_id]
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    else
      @pet = Pet.create(name: params[:pet_name])
      @owner = Owner.create(name: params[:owner_name])
      @pet.owner = @owner
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if params[:owner_name].empty?
      @pet = Pet.update(params[:id], name: params[:pet_name], owner_id: params[:owner_id])
    else
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.update(params[:id], name: params[:pet_name], owner_id: @owner.id)
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end
