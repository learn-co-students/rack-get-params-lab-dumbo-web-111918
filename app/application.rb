class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    
    elsif req.path.match(/cart/)
      if @@cart.empty? == true
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
      end
    end

    elsif req.path.match(/add/)
      add_item = req.params["item"]
      resp.write handle_add_item_to_cart(add_item)
      

    elsif req.path.match(/search/)
      # http://localhost:9292/search?q=Pears
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish

  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add_item_to_cart(add_item)
    #check to see if that item is in @@items
    if handle_search(add_item) == "#{add_item} is one of our items"
       #then add it to the cart if it is. 
       @@cart << add_item
        return "added #{add_item}"
    else
        #Otherwise give an error
        return "We don't have that item"
    end
  end

end
