ActiveAdmin.register SitePage do
  menu label: "Website Pages"

  permit_params :title, :slug, :content

  actions :index, :show, :edit, :update

  index do
    id_column
    column :title
    column :slug
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Page Content" do
      f.input :title
      f.input :slug
      f.input :content
    end

    f.actions
  end
end
