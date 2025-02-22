class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert
      new_actor = Actor.new
      
      new_actor.name = params.fetch("actor_name")
      new_actor.dob = params.fetch("actor_dob")
      new_actor.bio = params.fetch("actor_bio")
      new_actor.image = params.fetch("actor_image_url")
      new_actor.save

    redirect_to("/actors")
  end

  def delete
    actor_id = params.fetch("path_id")

    matching_records = Actor.where({ :id => actor_id }) # relation of all actors with the path_id (should be just one)
    the_actor = matching_records.first # pull out first (and only) actor from relation

    the_actor.delete
  
    redirect_to("/actors")
  end
end
