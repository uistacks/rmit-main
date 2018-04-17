class TransCategory < ActiveRecord::Base
  belongs_to :mst_categories, :class_name => "MstCategory"
  def self.upload_image(upload)
        ext = File.extname(upload.original_filename)
        name =  ((0...8).map { ((65 + rand(26)).chr)}.join)+(ext)
        directory = Rails.public_path.join('category_icon')
        # create the file path
        path = File.join(directory, name)
        # write the file
        File.open(path, "wb") { |f| f.write(upload.read) }
        return name
    end
end
