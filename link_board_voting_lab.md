#Implement Voting

We are going to implement hacker news style voting. This means you can only up vote and not down vote.

[http://news.ycombinator.com](http://news.ycombinator.com)


##Generate model

Vote model

* voteable:references
* user:references

Create polymorphic `vote` model `voteable`

* `Post` has\_many `Votes`
* `Votes` belongs\_to `Post`
* `Comment` has\_many `Votes`
* `Votes` belongs\_to `Comment`
* `Votes` belongs\_to `user`

Remember to edit migration and model then migrate.

##Test The Model

```
rails c

#list items
Post.all
Vote.all
Comment.all
User.all

#list votes (check association)
Post.first.votes
Comment.first.votes
User.first.votes

#add vote to post
User.first.votes << Post.first.votes.create

#add vote to comment
User.first.votes << Comment.first.votes.create

#list votes (now we should have some)
Post.first.votes
Comment.first.votes
User.first.votes

#number of votes
Post.first.votes.length
Comment.first.votes.length

```

##Routes

| verb | path | action |
|---|---|---|
| POST | /comments/:id/votes | add a vote to a comment |
| POST | /posts/:id/votes | add a vote to a post |


