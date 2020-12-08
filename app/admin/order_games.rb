ActiveAdmin.register OrderGame do
  permit_params :price, :sku, :qty, :pst, :gst
end
