# Todo

### Todo made with Elixir Supervisor from LearnElixir.tv


```
:observer.start
Todo.Server.add_list("Home")
Todo.Server.add_list("Work")
alias Todo.Item
home = Todo.Server.find_list("Home")
Todo.List.add(home, Item.new("Take out the trash"))
Todo.List.add(home, Item.new("Buy milk"))
```

