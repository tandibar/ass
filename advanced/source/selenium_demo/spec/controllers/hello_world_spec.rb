require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "HelloWorlds Controller", "index action" do
  before(:each) do
    @controller = HelloWorlds.build(fake_request)
    @controller.dispatch('index')
  end
end