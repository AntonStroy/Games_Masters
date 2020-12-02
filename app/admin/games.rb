ActiveAdmin.register Game do
  permit_params :sku, :name, :description, :release_date, :rating, :price, :stock, :link, :cover, :developer_id, :publisher_id,
                genre_games_attributes: %i[id game_id genre_id _destroy], platform_games_attributes: %i[id game_id platform_id _destroy]

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs "Game" do
      f.input :sku
      f.input :name
      f.input  :description
      f.input  :release_date
      f.input  :rating
      f.input  :price
      f.input  :stock
      f.input  :link
      f.input  :developer, as: :select
      f.input  :publisher, as: :select
      f.has_many :genre_games, allow_destroy: true do |n_f|
        n_f.input :genre
      end
      f.has_many :platform_games, allow_destroy: true do |n_f|
        n_f.input :platform
      end
      f.input :cover, as: :file, hint: f.object.cover.present? ? image_tag(f.object.cover) : ""
    end
    f.actions
  end
end
