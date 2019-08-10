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
    @pet = Pet.create(params[:pet])
    if params[:pet][:owner_id] == nil && owner_id = Owner.create(params[:owner]).id
      @pet.owner_id = owner_id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name] != ""
      @pet.owner_id = Owner.create(params[:owner]).id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
end
