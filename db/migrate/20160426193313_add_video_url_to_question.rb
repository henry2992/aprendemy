class AddVideoUrlToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :video_url, :string
  end
end
/#
id                       | integer
content                  | character varying
choice_id                | integer
sub_category_id          | integer
created_at               | timestamp
updated_at               | timestamp
answered_questions_count | integer
explanation              | character varying
picture                  | character varying
url
#/
