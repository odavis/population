class Analytics
  attr_accessor :options
  
  def initialize(areas)
    @areas = areas 
    set_options
  end

  def set_options
    @options =  []
    @options << {menu_id: 1, menu_title: 'Areas count', method: :how_many }
    @options << {menu_id: 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << {menu_id: 3, menu_title: 'Largest Population', method: :largest_pop }
    @options << {menu_id: 4, menu_title: 'Zipcodes in a State', method: :state_zips }
    @options << {menu_id: 5, menu_title: 'Information for a given zip', method: :zip_info }
    @options << {menu_id: 6, menu_title: 'Exit', method: :exit }
  end
  

  def run(choice)
    opt = @options.select {|o| o[:menu_id] == choice }.first
    if opt.nil?
      print "Invalid choice"
    elsif opt[:method] != :exit
      self.send opt[:method]
      :done
    else
      opt[:method]
    end
  end

  def how_many
    puts "There are #{@areas.length} areas"
  end

  def smallest_pop
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population
    end

    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    puts "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}"
    
  end

  def largest_pop
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population
    end

    largest = sorted.reverse.drop_while {|i| i.estimated_population == 0}.first

    puts "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
    
  end

  def state_zips
    print "Enter State (ex. FL): "
    state = gets.chomp
    s = @areas.count {|a| a.state == state}
    puts "There are #{s} zip code matches in #{state}"
  end

  def zip_info
    print "Enter Zipcode: "
    zip = gets.strip.to_i
    zip = @areas.select {|a| a.zipcode == zip}
    unless zip.empty?
      #print " "
      zip.each {|z| puts z}
    else
      puts "Zip not found"
    end
  end



end
