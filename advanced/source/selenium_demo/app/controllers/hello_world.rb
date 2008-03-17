class HelloWorld < Application
  
  def index
    render
  end
  
  def say_hello_to(name)
    @name = name
    render :template => 'hello_world/output'
  end
end