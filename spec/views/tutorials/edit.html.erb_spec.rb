require 'rails_helper'

RSpec.describe "tutorials/edit", type: :view do
  before(:each) do
    @tutorial = assign(:tutorial, Tutorial.create!(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit tutorial form" do
    render

    assert_select "form[action=?][method=?]", tutorial_path(@tutorial), "post" do

      assert_select "input#tutorial_title[name=?]", "tutorial[title]"

      assert_select "textarea#tutorial_description[name=?]", "tutorial[description]"
    end
  end
end
