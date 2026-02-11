module SpotsHelper
  def image_dimensions(image)
    if image.blob.metadata["identified"] && image.blob.metadata["width"] && image.blob.metadata["height"]
      width = image.blob.metadata["width"]
      height = image.blob.metadata["height"]
      "#{width}x#{height}"
    end
  end

  def image_alt_text(image)
    image_dimensions(image) || "image"
  end
end
