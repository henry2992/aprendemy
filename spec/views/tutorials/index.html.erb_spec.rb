require 'rails_helper'

RSpec.describe "tutorials/index", type: :view do
  before(:each) do
    assign(:tutorials, [
      Tutorial.create!(
        :title => "Title",
        :description => "MyText"
      ),
      Tutorial.create!(
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of tutorials" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
