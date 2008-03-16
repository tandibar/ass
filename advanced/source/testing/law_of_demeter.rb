# Who the heck is this Demeter guy ...
def current_item
  items = shoping_cart.items
  items.first
end

# I love this principle
def current_item
  shoping_cart.most_recent_item
end