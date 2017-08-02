class Picture < ApplicationRecord

include PictureUploader::Attachment.new(:picture)
end
