module Mumblr
  class Server < Sinatra::Base

    enable :logging


  # CONFIG


    configure :development do
      register Sinatra::Reloader
      $redis = Redis.new
    end


  # ROUTES

    # REDIRECT TO HOME PAGE
    get('/') do
      redirect to("/mumbles")
    end


    # HOME PAGE. Shows all mumbles
    get('/mumbles')do
       entry = $redis.lrange('wdi:mumblr', 0, -1)
        @mumbles = entry.map do |mumble|
        $redis.hgetall("mumbles:#{mumble}")
        end
      render(:erb, :index, :layout => :default_layout)
   end

    # SINGLE MUMBLE. Shows individual mumble
    get('/mumbles/show')do
    # binding.pry
      render(:erb, :single, :layout => :default_layout)
    end


    #NEW MUMBLE. Create a new mumble
    get('/mumbles/new')do
      render(:erb, :new, :layout => :default_layout)
    end

    get('/mumbles/:id') do
      @id = params[:id]
      @mumble = $redis.hgetall("mumbles:#{@id}")
       render(:erb, :single, :layout => :default_layout)
    end

    post('/mumbles')do
     binding.pry
      id = $redis.incr("new_entry")
      $redis.hmset("mumbles:#{id}",
      "text", params["text"],
      "image", params["image"],
      "date", params["date"],
      "tags", params["tags"],
      "author_email", params["author_email"],
      "author_handle", params["author_handle"],
      "author_thumbnail", params["author_thumbnail"]
      )
     $redis.rpush("wdi:mumblr", id)
      redirect to("/mumbles/#{id}")
    end

  end #end module
end #end class
