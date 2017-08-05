class PictureUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :activerecord
  plugin :determine_mime_type, analyzer: :mimemagic
  plugin :logging, logger: Rails.logger
  plugin :remove_attachment
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions, names: [:original,:medium, :thumb]


  Attacher.validate do
    validate_max_size 4.megabytes, message: 'is too large (max is 4 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  end

  def process(io, context)
    if context[:phase] == :store
      size_500 = resize_to_limit!(io.download, 500,500)
      #size_500 = resize_to_limit(size_700, 500,500)
      #size_300 = resize_to_limit(size_500, 300,300)
      #size_150 = resize_to_limit(size_500, 150, 150)
      thumb = resize_to_limit(size_500, 75, 75)
      { original: io, medium: size_500, thumb: thumb }
    end
  end
end