class AddLanguageToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :language, foreign_key: true
  end
end
