module V1
  class ImagesAPI < Grape::API
    namespace :images do
      desc 'Image data'
      get '/:id' do
        image = Image.find(params[:id])
        render ImageSerializer.new(image).serialized_json
      end
    end
  end
end
