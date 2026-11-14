interface ImageViewerProps {
  imageUrl: string;
  mimeType: string;
  alt: string;
}

export function ImageViewer({ imageUrl, alt }: ImageViewerProps) {
  return (
    <div className="xynoplex-image-viewer">
      <img
        src={imageUrl}
        alt={alt}
        className="xynoplex-image-viewer__image"
        style={{ imageRendering: 'auto' }}
      />
    </div>
  );
}
