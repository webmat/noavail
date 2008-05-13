module NoAvail
  def addr_free?(addr)
    begin
      Whois::Whois.new addr
      return ' NO'
    rescue Whois::WhoisException => ex
      return ' yes'
    end
  end

  def read_params(list)
    return [], [], [] if list.size == 0

    dot_pos         = list.index('.')
    names           = list[ 0, dot_pos || list.size ]
    user_extensions = dot_pos ? list[ dot_pos + 1, list.size ] : []
    extensions      = DEFAULT_EXTENSIONS + user_extensions.map{|ext| ".#{ ext.gsub(/\A\./, '') }" }
    header          = ['Avail?'] + extensions
    return names, extensions, header
  end

  def verify_all(names, extensions)
    VERIFICATION_STRATEGY.verify(names, extensions)
  end

  class Naive
    def verify(names, extensions)
      lines = names.map do |name|
        [name] + extensions.map {|ext| addr_free?(name + ext).to_s }
      end
      return lines, names.map{|a| a.length}.max
    end
  end

  class MultiThreaded
    def verify(names, extensions)
      threads = []
      lines = Array.new(names.size)

      names.each_with_index do |name, i|
        threads << Thread.new("thread #{i}") do 
          lines[i] = [name] + extensions.map {|ext| addr_free?(name + ext).to_s }
        end
      end
      threads.each{|t| t.join}

      return lines, names.map{|a| a.length}.max
    end
  end
end
