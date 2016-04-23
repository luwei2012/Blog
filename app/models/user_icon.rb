class UserIcon < ActiveRecord::Base
  belongs_to :user
  include ActiveModel::Validations
  validates_with Validator
  attr_accessor :file_upload
  include Backburner::Queue
  queue "encode-jobs" # defaults to 'user'
  queue_priority 500 # most urgent priority is 0
  #document_type
  queue_respond_timeout 300


  def del_uploads
    if self.original
      ext = File.extname self.original
      folder_prefix = self.original[0, self.original.index(ext)]
      full_folder_path = "#{Rails.root.to_s}/public#{folder_prefix}"
      `rm -rf #{full_folder_path}*`
    end

    if self.screenshot
      ext = File.extname self.screenshot
      folder_prefix = self.screenshot[0, self.screenshot.index(ext)]
      full_folder_path = "#{Rails.root.to_s}/public#{folder_prefix}"
      `rm -rf #{full_folder_path}*`
    end
  end

  def images_upload
    image_upload=self.file_upload
    file_extname = File.extname image_upload.original_filename
    file_name = image_upload.original_filename[0, image_upload.original_filename.index(file_extname)].gsub(/[' ','(',')']/, '_')
    new_file_name = "#{Time.now.strftime("%Y%m%d%H%M%S")}#{self[:user_id]}#{file_name}#{file_extname}"
    folder_path = "/image_uploads/#{Time.now.strftime("%Y") }/#{Time.now.strftime("%m")}/#{Time.now.strftime("%d") }/"
    url_path = folder_path + new_file_name
    full_folder_path = "#{Rails.root.to_s}/public#{folder_path}"
    new_file_path = "#{Rails.root.to_s}/public#{url_path}"
    unless File.exist? full_folder_path
      `mkdir -p #{full_folder_path}`
    end


    if !image_upload.original_filename.empty?
      File.open(new_file_path, "wb") do |f|
        f.write(image_upload.read)
        f.close
      end
    end

    #转换格式生成缩略图
    #小图路径
    small_url_thumbnail_path = url_path.gsub(file_extname, "-S#{file_extname}")
    small_thumbnail_path = new_file_path.gsub(file_extname, "-S#{file_extname}")

    %x(convert -resize #{THUMBNAIL_SIZE.small_width}x#{THUMBNAIL_SIZE.small_height} #{new_file_path} #{small_thumbnail_path})
    self.status = Document::ENCODE_SUCCESS
    self.original = url_path
    self.screenshot = small_url_thumbnail_path
    self.file_name = image_upload.original_filename
    self.upload_file_size = image_upload.size
    self.save
  end

  def to_jq_upload
    {
        'url' => self.original,
        'id' => self.id,
        'name' => self.file_name,
        'size' => self.upload_file_size,
        'thumbnail_url' => self.screenshot,
        'delete_url' => "/documents/#{self.id}",
        'delete_type' => 'DELETE'
    }
  end

  def destroy
    del_uploads
    with_transaction_returning_status { super }
  end
end
