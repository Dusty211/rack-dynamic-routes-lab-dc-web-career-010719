class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if !(req.path.match(/items/))
      resp.write "Route not found"
      resp.status = 404
    else
      find_item = req.path.split("/items/").last
      found_item = Item.all.find{|item| item.name == find_item}

      if found_item.class != NilClass
        resp.write(found_item.price)
      else
        resp.write "Item not found"
        resp.status = 400
      end

    end

    resp.finish

  end
end
