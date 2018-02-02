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
      [6] Create User
      [signup] Create User
      [login]  Login User (Create JWT)
      [logout] Logout User (Destroy JWT)
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
      when "6"
      when "signup"
        puts "Signup for a new account"
        puts
        parameters = {}
        print "Name: "
        parameters[:name]=gets.chomp
        print "Email: "
        parameters[:email]=gets.chomp
        print "Password: "
        parameters[:password]=gets.chomp
        print "Password confirmation: "
        parameters[:password_confirmation]=gets.chomp
        json_data = post_request("/users",parameters)
        puts JSON.pretty_generate(json_data)
      when "login"
        puts "Login"
        print "Email: "
        email = gets.chomp
        print "Password: "
        password = gets.chomp
        response = Unirest.post(
            "http://localhost:3000/user_token",
            parameters:{
              auth:{
                email:email,
                password:password
              }
            }
          )
        puts JSON.pretty_generate(response.body)
        jwt = response.body["jwt"]
        Unirest.default_header("Authorization","Bearer #{jwt}")
      when "logout"
        jwt = ""
        Unirest.clear_default_headers
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



