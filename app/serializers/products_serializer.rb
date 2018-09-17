class ProductsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :price

  attribute :image do |object|
    {
      url: object.preview.url
    }
  end
end
