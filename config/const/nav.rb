# -*- encoding : utf-8 -*-
ZONE_8_OFFSET = -ActiveSupport::TimeZone[8.0].utc_offset
IMAGE_REGEXP = Regexp.new(/[^\s]+(\.(?i)(jpg|png|gif|bmp|jpeg))$/)
VIDEO_REGEXP = Regexp.new(/[^\s]+(\.(?i)(mkv|avi|AVI|wmv|WMV|flv|FLV|mpg|MPG|mp4|MP4|mov))$/)

ERROR =
    {
        :shopping_error => 901,
        :normal => 900,
        :new_version => 902,
        :server_maintain => 903,
        :download_latest_version => 999,
        :over_3_account => 998,
        :session_error => 997,
    }


CLIENT_TYPE = {
    :iOS => 0,
    :Android => 1,
    :PC => 2,
}

#authority
#权限key-values
ROLE = {
    :admin => 0, #系统管理员
    :writer => 1, #洗车店
}


DOCUMENT_VALUE_KEY = {
    :all => 0,
    :image => 1,
    :audio => 2,
    :video => 3,
    :file => 4,
}


MESSAGE_TYPE={
    # :new_order => 0,
    # :wait_for_check => 1,
    # :order_cancel => 2,
    # :user_comment => 3,
    # :user_score => 4,
}


#缩略图尺寸
class THUMBNAIL_SIZE
  def self.middle_width
    return 413
  end

  def self.middle_height
    return 620
  end

  def self.large_width
    return 600
  end

  def self.large_height
    return 800
  end

  def self.small_width
    return 400
  end

  def self.small_height
    return 300
  end
end



