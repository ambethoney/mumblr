require 'redis'

redis.flushdb

redis.set("entry_id", 0)

id = redis.incr("entry_id")

mumbles = {

 redis.hset("mumblr:#{id}" =>{
  "text" = " ",
  "image" = " ",
  "date" = " ",
  "tags" = " ",
  "author_email" = " ",
  "author_handle" = " ",
  "author_thumbnail" - " ",
  "likes" = " "
  })

redis.lpush("entry_ids", id)

}
