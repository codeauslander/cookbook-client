require 'tty-table'
module RecipesViews
  SPACE = 40
  LINE = "-" * SPACE
  EQUALS = "=" * SPACE
  def recipes_show_view(recipe)
    puts LINE
    puts '... Recipe ...'
    puts "#{recipe.id} #{recipe.title} #{recipe.chef}" 
    puts "#{recipe.ingredients}"
    puts "#{recipe.directions}"
    puts "#{recipe.prep_time} #{recipe.created_at}"
    puts LINE    
  end
  def recipes_index_view(recipes)
    puts "Recipes table ..."
    table_rows = []
    recipes.each do |recipe|
      table_rows << [recipe.id, recipe.title, recipe.chef, recipe.ingredients, recipe.directions, recipe.prep_time, recipe.created_at]
    end
    table = TTY::Table.new header: ['Id','Title','Chef','Ingredients','Directions','Prep time','Created at'], rows: table_rows
    puts table.render(:ascii) 
  end
  def recipes_search_view(recipes)
    puts "... Recipes found ..."
    recipes_index_view(recipes)
  end
  def recipes_sort_view(recipes)
    puts "... Recipes sorted ..."
    recipes_index_view(recipes)
  end
  def recipes_create_view(recipe)
    puts "... Recipe succesfully created ..."
    recipes_show_view(recipe)
  end
  def recipes_update_view(recipe)
    puts "... Recipe succesfully updated ..."
    recipes_show_view(recipe)
  end
  def recipes_destroy_view(message)
    puts "Destroying recipe"
    puts message
  end
end
