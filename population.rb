require_relative 'lib/setup'
require_relative 'lib/analytics'

class Population
  def initialize
    areas = Setup.new().areas
    @analytics = Analytics.new(areas)
  end

  def menu
    system ("clear")
    puts "Population Menu"
    puts "---------------"

    @analytics.options.each do |opt|
      puts "#{opt[:menu_id]}. #{opt[:menu_title]}"
    end
    puts
  end

  def run
    stop = false

    while stop != :exit do 
      #menu
      self.menu
      #choice
      print "Choice: "
      choice = gets.chomp.to_i
      #run choice
      stop = @analytics.run(choice)
        if stop == :exit
          puts "Exiting"
        else
          print "Hit enter to continue"
          gets
        end
    end
  end
end

p = Population.new
p.run
