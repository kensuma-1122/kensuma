module Users
  class StampImagesController < Users::Base
    
    def create
      add_more_stamp_images(stamp_images_params[:images])
      flash[:error] = "Failed uploading images" unless @gallery.save
      redirect_to :back
    end
  
    def destroy
      binding.pry
      remove_stamp_image_at_index(params[:id].to_i)
      flash[:error] = "Failed deleting image" unless @gallery.save
      redirect_to :back
    end
  
    private
  
    def set_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end
  
    def add_more_images(new_images)
      images = @gallery.images 
      images += new_images
      @gallery.images = images
    end
  
    def remove_image_at_index(index)
       remain_images = @gallery.images
       if index == 0 && @gallery.images.size == 1
         @gallery.remove_images!
       else
         deleted_image = remain_images.delete_at(index) 
         deleted_image.try(:remove!)
         @gallery.images = remain_images
       end
    end
  
    def images_params
      params.require(:gallery).permit({images: []}) # allow nested params as array
    end
    
  end
end