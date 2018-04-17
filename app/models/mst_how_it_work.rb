class MstHowItWork < ActiveRecord::Base
	def self.upload_image(upload)
        ext = File.extname(upload.original_filename)
        name =  ((0...8).map { ((65 + rand(26)).chr)}.join)+(ext)
        directory = Rails.public_path.join('how_it_work_icon')
        # directory = "/home/vitewish/rails_apps/p1032/public/blog_images"
        # create the file path
        path = File.join(directory, name)
        # write the file
        File.open(path, "wb") { |f| f.write(upload.read) }
        return name
    end
end
