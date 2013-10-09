class CSVreader
  attr_accessor :filename, :headers

  def initialize(filename)
    @filename = filename
  end

  def headers=(header_str)
    @headers = header_string.spilt(",")
    @headers.map! {|h|

      #removes quotes
      h.gsub!('"', '')
      
      #remove new line
      h.strip!

      #snake-case
      h.underscore.to_sym
    }
  end

  def create_hash(values)
    h = {}
    @headers.each_with_index {|header, i|
      value = values[i].strip.gsub('"','')
      h[header] = value unless value.empty?
      }
    h
  end

end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end