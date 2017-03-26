module Guts
  # Medium model which utilizes PaperClip
  class Medium < ApplicationRecord
    include MultisiteScopeConcern

    # Regex used for sizing_only_images
    CONTENT_TYPE_REGEX = %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$}

    validates :title, presence: true, length: { minimum: 3 }

    belongs_to :filable, polymorphic: true, required: false
    has_many :tracks, as: :object
    has_attached_file(
      :file,
      source_file_options: { all: '-auto-orient' },
      styles: Guts.configuration.file_image_sizing,
      url: '/system/:class/:id_partition/:style/:filename',
      path: ':rails_root/public/system/:class/:id_partition/:style/:filename'
    )

    before_post_process :sizing_only_images

    validates_attachment_content_type(
      :file,
      content_type: Guts.configuration.file_allowed_content_types
    )

    # Determine if the file is an image
    # and can be resized by Paperclip
    # @return [Boolean] true for image, false for file
    def sizing_only_images
      false unless self[:file_content_type] =~ CONTENT_TYPE_REGEX
    end
  end
end
