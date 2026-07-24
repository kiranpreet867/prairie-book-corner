ActiveAdmin.register Product do
  permit_params :name,
                :description,
                :price,
                :stock_quantity,
                :on_sale,
                :category_id,
                :image,
                :remove_image

  includes :category

  index do
    selectable_column
    id_column
    column :name
    column :category
    column("Price") { |product| number_to_currency(product.price) }
    column :stock_quantity
    column :on_sale

    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image),
                  style: "width: 60px; height: 80px; object-fit: cover;"
      else
        "No image"
      end
    end

    column :created_at
    actions
  end

  filter :name
  filter :category
  filter :price
  filter :stock_quantity
  filter :on_sale

  form do |f|
    f.inputs "Book Information" do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :on_sale
      f.input :category

      if f.object.image.attached?
        li do
          image_tag url_for(f.object.image),
                    style: "max-width: 150px; height: auto;"
        end

        f.input :remove_image,
                as: :boolean,
                label: "Remove current image"
      end

      f.input :image,
              as: :file,
              hint: "Choose a file to add or replace the product image."
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :category
      row("Price") { |product| number_to_currency(product.price) }
      row :stock_quantity
      row :on_sale

      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image),
                    style: "max-width: 250px; height: auto;"
        else
          "No image uploaded"
        end
      end

      row :created_at
      row :updated_at
    end
  end
end
