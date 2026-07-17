class CreateSitePages < ActiveRecord::Migration[7.2]
  def change
    create_table :site_pages do |t|
      t.string :title
      t.string :slug
      t.text :content

      t.timestamps
    end
  end
end
