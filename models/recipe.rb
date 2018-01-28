class Recipe
  attr_accessor :id, :title, :chef, :ingredients, :directions, :created_at, :prep_time
  def initialize(input)
    @id = input["id"]
    @title = input["title"]
    @chef = input["chef"]
    @ingredients = input["ingredients"]
    @directions = input["directions"]
    @created_at = input["created_at"]
    @prep_time = input["prep_time"]
  end
end

