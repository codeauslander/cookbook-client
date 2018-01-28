module RecipesController
  DOMAIN = "http://localhost:3000"

  def recipes_show_action
    print "id: "
    id = gets.chomp
    url = DOMAIN + "/recipes/#{id}"
    response = Unirest.get(url)
    recipe_hash = response.body
    recipe = Recipe.new(recipe_hash)
    recipes_show_view(recipe)
  end
  def recipes_index_action
    url = DOMAIN + "/recipes"
    response = Unirest.get(url)
    recipes_hashs = response.body
    recipes = []
    recipes_hashs.each do |recipe_hash|
      recipes << Recipe.new(recipe_hash)
    end
    recipes_index_view(recipes)
  end
  def recipes_search_action
    print "Enter a search term: "
    search = gets.chomp
    url = DOMAIN + "/recipes?search=#{search}"
    response = Unirest.get(url)
    recipes_hashs = response.body
    recipes = []
    recipes_hashs.each do |recipe_hash|
      recipes << Recipe.new(recipe_hash)
    end
    recipes_search_view(recipes)
  end
  def recipes_sort_action(sort)
    puts "Sorting by #{sort}"
    url = DOMAIN + "/recipes?sort=#{sort}"
    response = Unirest.get(url)
    recipes_hashs = response.body
    recipes = []
    recipes_hashs.each do |recipe_hash|
      recipes << Recipe.new(recipe_hash)
    end
    recipes_sort_view(recipes)
  end
  def recipes_create_action
    url = DOMAIN + "/recipes"
    parameters = {}
    print "title: "
    parameters[:title] = gets.chomp 
    print "chef: "
    parameters[:chef] = gets.chomp
    print "ingredients: "
    parameters[:ingredients] = gets.chomp
    print "directions: "
    parameters[:directions] = gets.chomp
    response = Unirest.post(url,parameters:parameters)

    if response.code == 200

      recipe_hash = response.body
      recipe = Recipe.new(recipe_hash)
      recipes_create_view(recipe)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end   
    end
  end
  def recipes_update_action
    print "id: "
    id = gets.chomp
    url = DOMAIN + "/recipes/#{id}"
    recipe_hash = Unirest.get(url).body
    parameters = {}
    print "title (#{recipe_hash['title']}): "
    parameters[:title] = gets.chomp
    print "chef (#{recipe_hash['chef']}): "
    parameters[:chef] = gets.chomp
    print "ingredients(#{recipe_hash['ingredients']}): "
    parameters[:ingredients] = gets.chomp
    print "directions(#{recipe_hash['directions']}): "
    parameters[:directions] = gets.chomp
    response = Unirest.patch(url,parameters:parameters)
    if response.code == 200
      response = Unirest.get(url)
      recipe_hash = response.body
      recipe = Recipe.new(recipe_hash)
      recipes_update_view(recipe)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end   
    end
  end
  def recipes_destroy_action
    print 'Destroy recipe with Id: '
    id = gets.chomp
    url = DOMAIN + "/recipes/#{id}"

    response = Unirest.get(url)
    recipe_hash = response.body
    recipe = Recipe.new(recipe_hash)
    recipes_show_view(recipe)

    response = Unirest.delete(url)
    data = response.body
    recipes_destroy_view(data['message'])
  end
end 