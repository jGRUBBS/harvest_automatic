class Hash

  def symbolize_keys
    self.inject({}) do |hash, (k,v)|
      hash[k.to_sym] = v
      hash
    end
  end

end
