require_relative 'csv_reader'
require_relative 'area'

class Setup
  attr_accessor :areas

  def initialize
      csv = CSVReader.new("./free-zipcode-database.csv")
      @areas = []
      csv.read do |item|
        @areas << Area.new(item)
      end
    self
  end

  def read
    f = File.new(@filename, 'r')

    #Headers
    self.headers = f.readline

    #loop over lines
    while ((!f.eof?) && next_line = f.readline)
      values = next_line.split(',')
      hash = create_hash(values)
      yield(hash)
    end
  end

end