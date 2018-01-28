require 'unirest'
 require_relative 'controllers/recipes_controller'
 require_relative 'views/recipes_views'
 require_relative 'models/recipe'
class Frontend
  include RecipesController
  include RecipesViews
  def run
    running = true
    while running
      puts " Select an option for your cookbook
      [1] Show recipes
        [1.1] Search all recipes
        [1.2] Sort by chef
        [1.3] Sort by title
      [2] Create recipe
      [3] Show recipe
      [4] Update recipe
      [5] Destroy recipe
      Everything else bye
           "
      case gets.chomp
      when "1"
        recipes_index_action
      when "1.1"
        recipes_search_action
      when "1.2"
        recipes_sort_action
      when "1.3"
        recipes_sort_action
      when "2"
        recipes_create_action
      when "3"
        recipes_show_action
      when "4"
        recipes_update_action
      when "5"
        recipes_destroy_action
      else
        break
      end
      puts "Enter q to Quit"
      input_option = gets.chomp
      if input_option == "q"
        running = false
      end
    end
  end
end



