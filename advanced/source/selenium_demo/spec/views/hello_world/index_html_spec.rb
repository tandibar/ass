require File.join(File.dirname(__FILE__),'..','..','spec_helper')

describe "/hello_world" do
  before(:each) do
    @controller,@action = get("/hello_world")
    @body = @controller.body
  end

  it "should mention HelloWorld" do
    @body.should match(/HelloWorld/)
  end
end