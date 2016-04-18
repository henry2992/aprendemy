require 'rails_helper'

RSpec.describe "tutorials/new", type: :view do
  before(:each) do
    assign(:tutorial, Tutorial.new(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new tutorial form" do
    render

    assert_select "form[action=?][method=?]", tutorials_path, "post" do

      assert_select "input#tutorial_title[name=?]", "tutorial[title]"

      assert_select "textarea#tutorial_description[name=?]", "tutorial[description]"
    end
  end
end
